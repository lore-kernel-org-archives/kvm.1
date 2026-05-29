Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA331F981
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056944; cv=pass; b=D9WWBFVrkfZ+a4JAq7d42YlHEAtVvsoOC96dJzeG788BrWsmuBC0+DGzZdGYohS5j7JC7U6skmCs88tQZoUnfjm6fSAxxxatOxZDR1bh0ANCd3qAwHVt3ZPY2gL28Yi7QUwB0a3a9ZpU2v3tnE6x68yVfCZE+R0AFPYo8/ePugM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056944; c=relaxed/simple;
	bh=wBLsikgcWRjc6caTKkDxapksvxKzXWshhMu4aVKTHyI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=X/5KFv3n3TuH4fRFQdc8McTOLZNIiLj9by+9J9t9RvuLE3L4Iadr5K3+7xyMsf/D1kh6CJC3VHHR92EXjSbyTSUnNnDc0jKckabge+pBk5XYxIsforZZQtJAZNo+XsImuw6mD6huz5Lg888/AqXfGuvpu+6QSF1D0jtVY8OwgIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YP878SHO; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YP878SHO"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dc2b658544so17544327b3.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 05:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780056943; cv=none;
        d=google.com; s=arc-20240605;
        b=Ypa8/dt6VXJYRqg6QrjqJmeN6MQBGVd+bp5V3irQHeo0Z44XkpWPevpPX/PtBsbtLZ
         aNmN4ycQsarLG1swbYkyfCKkeAvmbKR1FmADpcOQblr9M2yXS0AQo3C43iQftyyj9J+j
         +m871pt1Vg78xC6xd34BQO9ac9cKWP8tv5n+0nitSerzrYa0HMZ1EiBiwD3Zbp8VxC/9
         PhPXUyReZoq9lkwjPPFjTQzj64bZwya5n9rJD3tS784JUiW3aAizJNPkGki5owjntj0F
         M4sh9wSOcpS++Bfd9vn1QwAVewCEmrQ5TB147PEdxnO7uIxgHdOjRTWkpiwvy3jpKgHg
         NWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=yjKGj59EYdEVZMYoNn1QX72MKnSy7HepRRbi+EYklHg=;
        fh=Kvpaq5uw2YActBQ6WkZ4Cd0Sm11qStrFdZmY5BbN78w=;
        b=BsQi+glHHsS5yKUMY+b6VJPjB/1YFYWYqv+qCSCZrg2BB/KKlMfdWcQ7T1/yQ++Cuh
         J4cDuAhkKIqbVv1g4bv74Hzw2D7CNRNTtcU/zcRC8Lq0jc1qziwSBXGYR4ig9YVa3PzP
         x5VKbA2iUK/JuVpymNiROK6dn0V3UBUEexnOzaLvctP25RmRoxr8eRjc6B/aYQ+Lcj8G
         4EZjGj8rChBJj281QrnMq5er/SCl4taFg1matIP/Sz3hICSF4grUiUJ2nn23VEjh/O9x
         YlZmFD3n4v7//NbtTIZ21ZveedZ/kWn/XgU9RDyKme34gTSGcNAD289CVkTZN8X+sQjN
         JyOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780056943; x=1780661743; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yjKGj59EYdEVZMYoNn1QX72MKnSy7HepRRbi+EYklHg=;
        b=YP878SHOnSKQK0APibqar9MT0C/WcH1z+vm4dzuosq1Xuu+9MZLsmeEhA4QF1uo+GG
         1FWcbTp40kZENdM5Bq6W8CkbFe0cNQNuh0rQ34sINC5TNAnq5HtVJCeNrD8Ae4Ol98Rx
         EJtH5gNwg41sWrtT0IoZ+3d1eQjo3omUWteuREo05VH8vtnfqVt5Maqm8sgT8H7Lv6TX
         Pt6YJmST4/2tBHnx8dXTSRcBPFB2sqVd+LaSmUZOG6Mi8RAVKGxoJrTOZoXnALntDuFD
         Ma9r1V6p+VCzrKqzNXYBaIKMeugKFZPXepNh+qDGrW5cCQgxlFfEsFwL5+qMl9XcwJnG
         vMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780056943; x=1780661743;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjKGj59EYdEVZMYoNn1QX72MKnSy7HepRRbi+EYklHg=;
        b=Zk3wgSvSUAOesCgVdI/rrRAeIQfkVR1YHOSrTek/BQxw24RxQMXvXldEg/Ay8F+t2E
         zE2qE6wKLW3SFcmuioInBJ4GGY3CERUWu/Ydeo0fhSyvDTsUISoimimhmEEwGtjEHOXX
         s4Q1UtmljSovzCKyHilfUjrie/qTO7rNLtO6+r++7NaMEG7TOHiKXLpICuEFrDo1TdtK
         oc11D+okxRvI/71vWpgyWWpNay2MRGCcJh/8bD5exB+ou3zGr55/nvRquMfeT8V1PZHj
         N9W7QezhSZ8q8WGgr8NtcJNPRBFpyBX7OObEUa06t1TN/4pMrqzasTtjwa9FUGy/p4Lq
         sbHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yN0vM9ojmpQafvGIuyLuP6K9gQ+WM/Wl0LebchlMvRpCOcmqhSJhwdeg2/ujQ6gMiINc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dqVw+pE/E+JLE+lpysPxC/EuUYiTFRftM/aLDF6agWkHOp9C
	1s0gRCRArbVxjEcaxcW7oPAvb0IUQowqTmnkdKHoaQgILAgaaz5j68McP295LJC3UjcbBGu8dju
	oX1UWIHWQNekdpeYRnVPqTGdw6a+cQdiaH2bHcKw7hE6gsi12lYda
X-Gm-Gg: Acq92OG6jFHej2ugaBQE6c801u62CYVfH7YHV2XPIO91aU7n3JRrCBx8+jciErZ7kQv
	yhIfmaMz89ZrJHv7SuKzxXWaidqsfWbf54VHmKPls66SX7I8zByPfFMd0v8JbfAkOsVxTayYVsu
	9T07uIgvllgypWAwi3S1wYs0StHbzIaZdW91AaAb0km0Iu4L0HMyZQWRaq13wtPSvHZPz5f3XPP
	I821jPbrFOggAUlhaxrHSKhSrhglbuDW68dOjXx9qDXHVj3dSdzqqLWBJgp7ylLBacT6xUGh89d
	lN57ffn4wHDUMXvugNN0ZFtNavmOLBdT6zydn91lrOcTSZoSlJ9ko6fN5V7a871so9lRPSU3bGn
	Wvw==
X-Received: by 2002:a05:690c:600c:b0:7d1:c256:b5c2 with SMTP id
 00721157ae682-7de49c3369bmr20746167b3.33.1780056942332; Fri, 29 May 2026
 05:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 13:15:31 +0100
X-Gm-Features: AVHnY4JLeR9AeYFBA5aawGm6vGHoYnsK642CUtkYU-vZUDUKpXBaG742LlgMaNQ
Message-ID: <CAFEAcA-H-bsjnvCPg71BMre7=6ZQ9f-tSU_XZcPPSgXkK+dDXA@mail.gmail.com>
Subject: KVM Forum 2026: Call For Presentations
To: QEMU Developers <qemu-devel@nongnu.org>, rust-vmm@lists.opendev.org, 
	kubevirt-dev@googlegroups.com, kvm-devel <kvm@vger.kernel.org>, 
	coconut-svsm@lists.linux.dev, libvirt-devel <devel@lists.libvirt.org>, 
	edk2-devel-groups-io <devel@edk2.groups.io>
Content-Type: text/plain; charset="UTF-8"

####################
KVM Forum 2026
November 12-13, 2026
Vancouver, Canada
####################

On behalf of the program committee for the KVM Forum, I am pleased to
announce the KVM Forum 2026 Call for Presentations.

CALL FOR PRESENTATIONS
======================

We encourage you to submit presentations via Pretalx at

     https://kvm-forum.qemu.org/2026/cfp/

All presentation slots will be 25 minutes + 5 minutes for questions.

Suggested topics:
- Scalability and Optimization
- Hardening and security
- Confidential computing

KVM and the Linux Kernel
- New Features and Architecture Ports
- Device Passthrough: VFIO, mdev, vDPA
- Network Virtualization
- Virtio and vhost

Virtual Machine Monitors and Management
- VMM Implementation: APIs, Live Migration, Performance Tuning, etc.
- Multi-process VMMs: vhost-user, vfio-user, QEMU Storage Daemon
- QEMU without KVM: Hypervisor.framework, Hyper-V, etc.
- Managing KVM: Libvirt, KubeVirt, Kata Containers

Emulation
- New Devices, Boards and Architectures
- CPU Emulation and Binary Translation

Developer-focused content
- Tooling improvements
- Enabling Rust
- Testing frameworks and strategies

Speakers are expected to attend in person.

IMPORTANT DATES
===============

The deadline for submitting presentations is:
   2026-08-01 00:00 (Canada/Pacific)

Accepted speakers will be notified on August 21, 2026.

ATTENDING KVM FORUM
===================

The cost of admission to KVM Forum 2026 is $75. You can get your ticket at

     https://kvm-forum.qemu.org/2026/register/

Admission is free for accepted speakers.

The conference will be held at Coast Coal Harbour Hotel Vancouver by APA
in Vancouver, Canada. More details about the location, and about the
reduced price rooms available for attendees at the conference hotel,
can be found at:

     https://kvm-forum.qemu.org/location/

If you need a visa invitation letter in order to attend, please reach out
to the organizers at kvm-forum-pc@redhat.com.

We are committed to fostering an open and welcoming environment at our
conference. Participants are expected to abide by our code of conduct
and media policy:

      https://kvm-forum.qemu.org/coc/
      https://kvm-forum.qemu.org/media-policy/

CONTACTS
========

Reach out to us should you have any questions. The program committee may
be contacted as a group via email: kvm-forum-pc@redhat.com.

--
Peter Maydell
