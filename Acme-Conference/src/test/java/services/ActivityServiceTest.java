
package services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.validation.ConstraintViolationException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import utilities.AbstractTest;
import domain.Activity;
import domain.Author;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"classpath:spring/junit.xml"
})
@Transactional
public class ActivityServiceTest extends AbstractTest {

	@Autowired
	ActivityService	activityService;

	@Autowired
	AuthorService	authorService;


	@Test
	public void CreateActivityDriver() {

		final Object testingData[][] = {
			{

				"admin", "conference0", "author0", "title", null
			}, {

				"admin", "conference0", "author0", "", ConstraintViolationException.class
			}
		};

		for (int i = 0; i < testingData.length; i++)
			this.createActivityTemplate((String) testingData[i][0], super.getEntityId((String) testingData[i][1]), super.getEntityId((String) testingData[i][2]), (String) testingData[i][3], (Class<?>) testingData[i][4]);
	}
	protected void createActivityTemplate(final String beanName, final Integer conferenceId, final Integer auhtorId, final String title, final Class<?> expected) {
		Class<?> caught;
		caught = null;

		try {
			super.authenticate(beanName);
			final Activity a = this.activityService.create(conferenceId);
			a.setDuration(23);
			a.setRoom("room");
			a.setStartMoment(new Date());
			a.setSummary("summary");
			a.setTitle(title);
			a.setType("TUTORIAL");
			final Collection<String> cols = new ArrayList<>();
			a.setAttachments(cols);
			final Collection<Author> col = new ArrayList<Author>();
			col.add(this.authorService.getAuthor(auhtorId));
			a.setAuthors(col);
			a.setPaper(null);
			this.activityService.save(a);
			this.activityService.flush();
			super.unauthenticate();
		} catch (final Throwable oops) {
			caught = oops.getClass();
		}

		this.checkExceptions(expected, caught);
	}
}
