Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BE3C13EE
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151325; cv=none; b=IMqF/4JDsnFsPS99ZMoSf2EgFD3KRGMHcrm0AYZFFCK6XucexDKLUgSu/1plazcsm7qx4xn9TTHOsMV81lhW6b1edFgwKcm5m4dR4HYfp94dWPjFGfd/gzuiGMBTcjLqNtVISToBb3TEP5rfvC8iOSQODyDkRdr7TpN6O1VBZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151325; c=relaxed/simple;
	bh=9XASCIVcrtx2hD56dtKvrYEwz2gZJTaYTfmQ/QyQdJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cr13CkRSMROwcSWBkb9Y9xB57vlv/wRDed+PgwsTB8yyf/IPlefwxtENAl4UR4UuM6kLoSa+EXTs2hMNkIQ7kYmrlv4LbRzLwhcHCCrpu2UjK4bSn98+sDFWnfKTUJArApYhJezkT9f/hNX2L8OKtcQH0V5MYrFhyltDZR6m/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eV8g5puA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eV8g5puA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b23c909256so17380555ad.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151323; x=1775756123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZyn90piJuJHk0Dg2pjvCy32w5/4/2gu6Xn8JH/XHiY=;
        b=eV8g5puAr+/f1EtKDIrDOvSgfvDgbFJuHTaHRgxrpvBR+FpXgjPOIyts4DBu8ch8HX
         4W/kU5P4Jka+0Yh9OSO/zCJFOoV3KLFxnmB/kvnXj5zuKa1rtHwXt/mhbelotHZomAW2
         z3ghcYhk8iyBDTrnFhUUt7STzOPHoeik8sB4A4XfT1n97EFsmy07/x4c4jCJoptEGeMY
         jesmhnNWBLnzY57rEn7MfZTdBC+IYQjq9kt4WOG5s/pj8FVZaCCgax2REmG88/Jyd5yM
         TjiYH81PblQ2Zvf/128Xz2tVWCQQCB/gvkl9bru8BQY9FWF2c1riYCuGaf2D2GpNk/6Y
         Lgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151323; x=1775756123;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SZyn90piJuJHk0Dg2pjvCy32w5/4/2gu6Xn8JH/XHiY=;
        b=NVY8ir5ZvE2Ri3Bjx9SPPkImmwSaXHl86poK6qJra0BEJsDFysIwlIO66Zu7iyn/8u
         I9ZOTLxstCv00ddgJAEPW7/t9zFQVOvp2ocFpRO3ZRZxiCInHxWHE/tL/lV7WZFGp9hU
         vFM7/46b6vJG8Su8M/1S6JN5zRgOhLsMTu3JggtGoAvs1rOxx1VQmfmzc3DUzfzjLjsC
         A0DIljVunAnCXwlKJrIYVjIi9u3h57c691X10c8oUXjh2zbjgqDrtZmPNI0W1fclXVf8
         BbEphHgzNYUwXPi7ezcGpMopdKUc2eN9RpDVJNlLGS3+AIghq9sKDW9KliiRPZPjM8qL
         vMlw==
X-Forwarded-Encrypted: i=1; AJvYcCXcDJejdL/VFwJsHpvdyXNnMrhlg+NhjsxvKctImcQ88QHccIURpfKTcjlFwqMRzItREko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvtFBexsjeWRKiy6gRv7JP0CYlaMT5Pv9tkWz+hcnrumdFyclZ
	BXauWPvD/+uZX4Jw+xYiDqOJjEr2m36uH2Kl203rczYteL8vGqJidCIf9/fwMYugtN1F3uorbm2
	yogTdTQ==
X-Received: from plgy18.prod.google.com ([2002:a17:903:22d2:b0:2b0:663c:53a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf05:b0:2b0:6a22:5159
 with SMTP id d9443c01a7336-2b28164cfd5mr1579645ad.1.1775151322844; Thu, 02
 Apr 2026 10:35:22 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:35:21 -0700
In-Reply-To: <CAAdrzjvvxX3eEkCBUvSud7qyaSUdzecgAkX1=f+ZQe7Q6ws69A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <ac1hI93pEo-x-7YU@google.com>
 <ac1pUx_jYv2yCMnX@google.com> <ac1s55_oLEUQx8Hs@google.com>
 <ac18LHQLalPb4z0-@google.com> <CAAdrzjugqk=APteY4oZNsa2e5kv5-=HBekyYfpzrwFUZ_WapsQ@mail.gmail.com>
 <CALzav=cO48f7f8yaN6EsSL4uGpojvY7gmCe9oOy+sP_+Kii4mw@mail.gmail.com>
 <ac26haU_7nXYWke1@google.com> <CAAdrzjvvxX3eEkCBUvSud7qyaSUdzecgAkX1=f+ZQe7Q6ws69A@mail.gmail.com>
Message-ID: <ac6o2Z_cs0HA6PpG@google.com>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026, Josh Hilke wrote:
> On Wed, Apr 1, 2026 at 5:38=E2=80=AFPM Josh Hilke <jrhilke@google.com> wr=
ote:
> > > > > > > > struct vfio_pci_device *kvm_vfio_device_init(const char *bd=
f)
> > > > > > > > {
> > > > > > > >   struct vfio_pci_device *device;
> > > > > > > >   struct iommu *iommu;
> > > > > > > >
> > > > > > > >   iommu =3D iommu_init(default_iommu_mode);
> > > > > > > >
> > > > > > > >   device =3D vfio_pci_device_init(bdf, iommu);
> > > > > > > >   if (!device) {
> > > > > > > >           vfio_pci_device_print_drivers(stderr);
> > > > > > > >           TEST_FAIL("No driver found for BDF '%s'", bdf);
> > > > > > > >   }
> > > > > > > >   return device;
> > > > > > > > }
> > > > > > > >
> > > > > > > > Because as is, this requires way too much a priori knowledg=
e and magic for
> > > > > > > > upstream.  The user shouldn't have to dig through code just=
 to understand what
> > > > > > > > devices are supported.
> > > > > > > >
> > > > > > > > Ideally, VFIO selftests would also provide a script, utilit=
y, and/or helper to
> > > > > > > > identify BDFs for devices it has drivers for.  In my experi=
ence, binding a device
> > > > > > > > to VFIO is trivial.  Finding the device in the first place =
is more annoying.
> > > > > > >
> > > > > > > Agree this would be nice to have. Is this a blocker for this =
series?
> > > > > >
> > > > > > Yes.  As I mentioned to Josh off-list, I'm not willing to accep=
t a "we pinky-swear
> > > > > > we'll make this stuff user friendly".  It's not that I don't tr=
ust you and Josh
> > > > > > (and others), it's that for me, this level of user-friendly beh=
avior isn't nice
> > > > > > to have, it's mandatory for these tests to be usable upstream.
> > > > > >
> > > > > > Internally we can squeak by with barebones, unhelpful tests, be=
cause the run
> > > > > > commands are often hardcoded somewhere and there is piles of do=
cumentation elsewhere.
> > > > > > But for upstream, none of that holds true.
> > > > > >
> > > > > > If it were weeks of effort, I would be more open to treating th=
is as nice to have,
> > > > > > but AFAICT writing the code should be less than a days worth of=
 work.
> > > > >
> > > > > Yeah that's fine, I don't think it adds too much extra work, and =
it's
> > > > > something I'd like to have anyway. I just wanted to confirm if it=
 should
> > > > > be part (or merged ahead of this series) or can be separate. Than=
ks!
> > > >
> > > > So I need to add kvm_vfio_device_init() and it will call
> > > > vfio_pci_has_driver(). Then, kvm_vfio_device_init() will TEST_FAIL =
if
> > > > vfio_pci_has_driver() returns false, correct?
> > > >
> > > > Should kvm_vfio_device_init() live in
> > > > tools/testing/selftests/kvm/lib/kvm_util.c?
> > >
> > > I was thinking the new test would do:
> > >
> > >   TEST_REQUIRE(vfio_pci_has_driver_send_msi(device));
> > >
> > > instead of:
> > >
> > >   TEST_REQUIRE(device->driver.ops);
> > >
> > > vfio_pci_has_driver_send_msi() would call vfio_pci_has_driver()
> > > internally and also check that send_msi op is non-null. Both function=
s
> > > would also log error messages if driver/send_msi is missing to help
> > > the user, as Sean requested.
> > >
> > > And you'll also need to a patch to add a helper script to print the
> > > list of BDFs on the current host that have a VFIO selftests driver. I=
t
> > > might make sense to send that as a standalone patch if Sean is ok wit=
h
> > > that.
> >
> > That makes sense for setup_msi(). But in Sean's implementation of
> > kvm_vfio_device_init() above, it looks like he wants the test to fail i=
f
> > there's no VFIO selftest driver for the BDF passed into the test.
>=20
> Whoops, never mind. I missed part of the discussion above. We're only
> requiring a VFIO selftest driver if we're using device MSIs, correct?

From a user-friendliness perspective, I don't see the point in trying to su=
pport
devices for which there is no selftest driver.  The *best* case scenario is=
 that
the user gets lucky and picks a device that has MSI-X capabilities, and thu=
s is
able to run the test in a degraded mode.

If the device doesn't have MSI-X capabilities, the test will skip thanks to=
 this
check:

	TEST_REQUIRE(device->msix_info.count > 0);
	vfio_pci_msix_enable(device, 0, 1);

Which is "fine", but IMO, the extra complexity, subtlety and potential for
confusion doesn't justify the coverage provided, because the coverage provi=
ded
is basically zero relative to what coverage is provided by dedicated KVM_IR=
QFD
and VFIO IRQ tests.  And most importantly requiring VFIO makes it practical=
ly
impossible to run the test by default.

Doing VFIO_DEVICE_SET_IRQS via vfio_pci_irq_trigger() is just a convoluted,
comically slow way of doing eventfd_signal().  The VFIO =3D> eventfd_signal=
() path
can be fully tested by having userspace listen on the eventfd, and the
eventfd_signal() =3D> KVM IRQ injection path can be fully tested by having =
userspace
signal the eventfd directly.

I'm a-ok doing a short pass of the test with vfio_pci_irq_trigger() to smok=
e
test things before proceeding to the "real" test, but IMO making the
vfio_pci_irq_trigger() path a standalone mode for the test is pointless.

However!  We _do_ have a KVM testing gap that can be trivially filled as th=
ere
is no existing eventfd_signal() =3D> KVM IRQ injection selftest.  And this =
test is
pretty much exactly that.  I just don't want to deal with jumping through V=
FIO
hoops for effectively no coverage (for KVM).

If we strip out that fluff, then the test is runnable without _any_ VFIO
involvement, which means it can run by default, e.g. in n environments with=
out
VFIO or VFIO-able devices, e.g. in automated CI testgrids.

Something like so.  And then we should also rename the test to drop vfio_pc=
i from
the name, as the VFIO aspect becomes purely optional.

---
 .../testing/selftests/kvm/vfio_pci_irq_test.c | 105 ++++++++----------
 1 file changed, 48 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testin=
g/selftests/kvm/vfio_pci_irq_test.c
index 807e9aecc887..70c61fe9f4d0 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -156,42 +156,34 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi,=
 struct kvm_vcpu *vcpu,
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, routes);
 }
=20
-static int setup_msi(struct vfio_pci_device *device, bool use_device_msi)
+static int vfio_setup_msi(struct vfio_pci_device *device)
 {
 	const int flags =3D MAP_SHARED | MAP_ANONYMOUS;
 	const int prot =3D PROT_READ | PROT_WRITE;
 	struct dma_region *region;
=20
-	if (use_device_msi) {
-		/* A driver is required to generate an MSI. */
-		TEST_REQUIRE(device->driver.ops);
+	/* A driver is required to generate an MSI. */
+	TEST_REQUIRE(device->driver.ops);
=20
-		/* Set up a DMA-able region for the driver to use. */
-		region =3D &device->driver.region;
-		region->iova =3D 0;
-		region->size =3D SZ_2M;
-		region->vaddr =3D kvm_mmap(region->size, prot, flags, -1);
-		TEST_ASSERT(region->vaddr !=3D MAP_FAILED, "mmap() failed\n");
-		iommu_map(device->iommu, region);
+	/* Set up a DMA-able region for the driver to use. */
+	region =3D &device->driver.region;
+	region->iova =3D 0;
+	region->size =3D SZ_2M;
+	region->vaddr =3D kvm_mmap(region->size, prot, flags, -1);
+	TEST_ASSERT(region->vaddr !=3D MAP_FAILED, "mmap() failed\n");
+	iommu_map(device->iommu, region);
=20
-		vfio_pci_driver_init(device);
+	vfio_pci_driver_init(device);
=20
-		return device->driver.msi;
-	}
-
-	TEST_REQUIRE(device->msix_info.count > 0);
-	vfio_pci_msix_enable(device, 0, 1);
-	return 0;
+	return device->driver.msi;
 }
=20
-static void send_msi(struct vfio_pci_device *device, bool use_device_msi, =
int msi)
+static void trigger_interrupt(struct vfio_pci_device *device, int eventfd)
 {
-	if (use_device_msi) {
-		TEST_ASSERT_EQ(msi, device->driver.msi);
+	if (device)
 		vfio_pci_driver_send_msi(device);
-	} else {
-		vfio_pci_irq_trigger(device, VFIO_PCI_MSIX_IRQ_INDEX, msi);
-	}
+	else
+		eventfd_signal(eventfd);
 }
=20
 static void help(const char *name)
@@ -236,7 +228,7 @@ int main(int argc, char **argv)
 	u8 vector =3D 32 + rand() % (UINT8_MAX - 32);
=20
 	/* Test configuration (overridable by command line flags). */
-	bool use_device_msi =3D false, irq_affinity =3D false, pin_vcpus =3D fals=
e;
+	bool irq_affinity =3D false, pin_vcpus =3D false;
 	bool empty =3D false, nmi =3D false;
 	int nr_irqs =3D 1000;
 	int nr_vcpus =3D 1;
@@ -244,19 +236,18 @@ int main(int argc, char **argv)
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t vcpu_threads[KVM_MAX_VCPUS];
 	u64 irq_count, pin_count, piw_count;
+	const char *device_bdf =3D NULL;
 	struct vfio_pci_device *device;
 	struct iommu *iommu;
 	cpu_set_t available_cpus;
-	const char *device_bdf;
 	FILE *irq_affinity_fp;
 	int i, j, c, msi, irq;
 	struct kvm_vm *vm;
 	int irq_cpu;
 	int ret;
=20
-	device_bdf =3D vfio_selftests_get_bdf(&argc, argv);
=20
-	while ((c =3D getopt(argc, argv, "abdehi:npv:xt:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "abd:ehi:npv:xt:")) !=3D -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity =3D true;
@@ -265,7 +256,7 @@ int main(int argc, char **argv)
 			block =3D true;
 			break;
 		case 'd':
-			use_device_msi =3D true;
+			device_bdf =3D optarg;
 			break;
 		case 'e':
 			empty =3D true;
@@ -301,20 +292,23 @@ int main(int argc, char **argv)
 	if (!x2apic)
 		virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
=20
-	iommu =3D iommu_init(default_iommu_mode);
-	device =3D vfio_pci_device_init(device_bdf, iommu);
-	msi =3D setup_msi(device, use_device_msi);
-	irq =3D get_irq_number(device_bdf, msi);
+	if (device_bdf) {
+		iommu =3D iommu_init(default_iommu_mode);
+		device =3D vfio_pci_device_init(device_bdf, iommu);
+		msi =3D vfio_setup_msi(device);
+		irq =3D get_irq_number(device_bdf, msi);
+		irq_count =3D get_irq_count(irq);
=20
-	irq_count =3D get_irq_count(irq);
-	pin_count =3D get_irq_count_by_name("PIN:");
-	piw_count =3D get_irq_count_by_name("PIW:");
+		eventfd =3D device->msi_eventfds[msi];
=20
-	printf("%s %s MSI-X[%d] (IRQ-%d) %d times\n",
-	       use_device_msi ? "Triggering" : "Notifying the eventfd for",
-	       device_bdf, msi, irq, nr_irqs);
+		printf("Using device %s MSI-X[%d] (IRQ-%d)\n",
+		       device_bdf, msi, irq);
+	} else {
+		device =3D NULL;
+		eventfd =3D kvm_new_eventfd();
+	}
=20
-	kvm_assign_irqfd(vm, gsi, device->msi_eventfds[msi]);
+	kvm_assign_irqfd(vm, gsi, eventfd);
=20
 	sync_global_to_guest(vm, x2apic);
 	sync_global_to_guest(vm, block);
@@ -341,6 +335,8 @@ int main(int argc, char **argv)
 	if (irq_affinity) {
 		char path[PATH_MAX];
=20
+		TEST_ASSERT(device, "Manipulating IRQ affinity requires a device");
+
 		snprintf(path, sizeof(path), "/proc/irq/%d/smp_affinity_list", irq);
 		irq_affinity_fp =3D fopen(path, "w");
 		TEST_ASSERT(irq_affinity_fp, "fopen(%s) failed", path);
@@ -371,17 +367,14 @@ int main(int argc, char **argv)
 			pin_vcpu_threads(nr_vcpus, rand() % get_nprocs(), &available_cpus);
=20
 		for (j =3D 0; j < nr_vcpus; j++) {
-			TEST_ASSERT(
-				!READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]),
-				"IRQ flag for vCPU %d not clear prior to test",
-				vcpu->id);
-			TEST_ASSERT(
-				!READ_FROM_GUEST(vm, guest_received_nmi[vcpu->id]),
-				"NMI flag for vCPU %d not clear prior to test",
+			TEST_ASSERT(!READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]),
+					"IRQ flag for vCPU %d not clear prior to test",
 				vcpu->id);
+			TEST_ASSERT(!READ_FROM_GUEST(vm, guest_received_nmi[vcpu->id]),
+				    "NMI flag for vCPU %d not clear prior to test", vcpu->id);
 		}
=20
-		send_msi(device, use_device_msi, msi);
+		trigger_interrupt(device, eventfd);
=20
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		for (;;) {
@@ -416,7 +409,7 @@ int main(int argc, char **argv)
 	for (i =3D 0; i < nr_vcpus; i++) {
 		if (block) {
 			kvm_route_msi(vm, gsi, vcpus[i], vector, false);
-			send_msi(device, false, msi);
+			trigger_interrupt(device, eventfd);
 		}
=20
 		pthread_join(vcpu_threads[i], NULL);
@@ -425,15 +418,13 @@ int main(int argc, char **argv)
 	if (irq_affinity)
 		fclose(irq_affinity_fp);
=20
-	printf("Host interrupts handled:\n");
-	printf("  IRQ-%d: %lu\n", irq, get_irq_count(irq) - irq_count);
-	printf("  Posted-interrupt notification events: %lu\n",
-	       get_irq_count_by_name("PIN:") - pin_count);
-	printf("  Posted-interrupt wakeup events: %lu\n",
-	       get_irq_count_by_name("PIW:") - piw_count);
+	if (device) {
+		printf("Host interrupts handled:\n");
+		printf("  IRQ-%d: %lu\n", irq, get_irq_count(irq) - irq_count);
=20
-	vfio_pci_device_cleanup(device);
-	iommu_cleanup(iommu);
+		vfio_pci_device_cleanup(device);
+		iommu_cleanup(iommu);
+	}
=20
 	return 0;
 }

base-commit: 97efbd75a6c9ef0946234df78d3b656e28035883
--
