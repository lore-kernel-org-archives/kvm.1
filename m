Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B582FC01B
	for <kvm@vger.kernel.org>; Sun,  3 May 2026 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777843703; cv=none; b=EXqIVxpNYWCaiyjmPrJgSvbCNJuYu/rEvHwhErQAPvk9KRouLdGzIJwMjIrwJnqWjxhcV1nTZgySGN5FKYKhhBhzinJmYbJMchc1DOI8j3HX2rb1KoPFyYZ6IhVJegEE0/j7r+zs61+lExTcfUKyDnrXih/1Bxu2AO0aIS8oA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777843703; c=relaxed/simple;
	bh=p1+53MgjG3tRE4zXVmx3A+yzO575nwGdlDEr5UF4Wr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWmrYuUufBc28pbaEsltlF9TCbvaB8O6pB007EE9KnhXD5dMbPW03yYnFMu/9a3/RwmlHe+Bp9oIwmjmhJeTe0hvekQzEcqY92tWNBreNZFz9GkZwnMM2qZdnYwPvDsCeoPt+IevxGOJ3cJy21vCTYSJ+IpDevkDc7USp7JDpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMk/5syW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pijTBlbN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMk/5syW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pijTBlbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777843700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g/jy3K0DTnk1EpdHbq98KlNCKdivc2YZwBxANLQFwTQ=;
	b=GMk/5syW4dnUl2IDnFSuMGPJ39XZwnep6qP6RHMe9R8PL/0ihDguoIRMQpvekF4vhanjgY
	SkItafqjJDk8Baa2dS/tPckugaL/7bzKmCPyPAyo8KHjSoM1+UdwpQlYSCn50+i1wZAhqR
	SwZRIbz1sKlMm2BvtV9aFH/o+V/zUV8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-uLSZaohpNUajxGBGqCPGHA-1; Sun, 03 May 2026 17:28:18 -0400
X-MC-Unique: uLSZaohpNUajxGBGqCPGHA-1
X-Mimecast-MFC-AGG-ID: uLSZaohpNUajxGBGqCPGHA_1777843698
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7d0947aeso1452141f8f.3
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 14:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777843697; x=1778448497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/jy3K0DTnk1EpdHbq98KlNCKdivc2YZwBxANLQFwTQ=;
        b=pijTBlbN/fvjqWkAsqxLI8If6uOOQm6w2HlXQ0kjL35BzHwl1KvOcGtH5e39WGfqOo
         ghg1m5qfdCnP4VzTv+t5G+pAgoNKzL7GuRidNHk6ZO9aBmzW0jy2KERDtMPGcGEMZnqv
         x7URJSf+BhDmmo/JgrVIOEf1OjcCvxlFrmkRIcGi2DRJjYv2pmKfSd61v3lZcewOhB0s
         +47WC0BFS0k1D/SfH707idiz4pVw2waK3UVPxqc6kdOZcujv1QsN7X25srnJMFrrh8Mk
         f8tBGFE/tDr/k3ASrXYAZUW6qhlzVR+JvkgYE36MAe99K5cVenh/7hewdRtzmQ3J/l5i
         YklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777843697; x=1778448497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/jy3K0DTnk1EpdHbq98KlNCKdivc2YZwBxANLQFwTQ=;
        b=V0cA4a0EIGsis2ZBil4mBMzcBjNtniSS7HyHm9KNNEdqyOiWvCuuKgAGn6B+wjKXOP
         n40Ey5+dSb10F/hei3EUxJDraIbGofrYqWz6O6L9yDDVxPLk/IaMT5lxLQbkDBduT+Xd
         Pnvy33lPM8lPA+2bULtfTsKII/dAs3AIKYolGooCVIAbkYXnAHkz35INxok/Bwh+ZkPd
         JC5IFlqqTn+HgNe+rr9zarFXTtOyY7DNnUoqIsBbxSFwEMSNGi4luImapNGPT17K/WjR
         v/15rWbExbH0RpLLYb4EPNZtSw2OvitjbXL/QBtwctZ5Z/Z744mvH+hRsJDgqte+3aH+
         gc6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9dSvBvm3JYvaNmCUnG3InrVh2TMAYZGfRrpUmKTjTe3sfURAa4XHIKban1AFTNboiCFDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6Fof06rVcFVvbORk7MHXArOQozYtafezf0N8E2arPUrn7Z/w
	tyN+5l5Lv3jBD1oCh+l972hrDrYRfVIYd4RHxj+CK9omNmaPhcUUmNuFKVhLA0b8gkgkWCkpyqu
	+HnYAwtdvowWOMfoak7aw3x60YQhTiRXjxfIqtQs9O/C1oaPS5Fnfdg==
X-Gm-Gg: AeBDieuIZRUt+rQBFggwXijiX8Zds2saZjxe8G6quJ53ZL+DJUNKRRUKZAHgQdS3Sa4
	vM1VgKHSO2Hn7/piwARmbYOxQ3XO4tGmQ6aJMI6sRS4lOlqe6vsfGFlTQEJdAg0eyDgbw+Cut0H
	QATlDPMVviRJt8N4FIwKcsFWLX+3edjoekQROMK9i1HRSxprO5NqqsWvlbWKA52omjt3Z0Sg/45
	vMvqSRwBZ0hBqcoCDuckTfZ+aM5FJIuz/4vNinEMvGP1LDFJA9VibraOHII6C3yQ22bUqTTpUWk
	NnwaQ3WqwtRWmTR/QBgSji+tZbhoifcD/ACO8y0/wSPOeFWEWENcH05JP9xWwUnpgHNHZHgLDK0
	lWpkEjuiBPpvv7gTaZa1lu9DmGVM4z300+/WPfQITHBWf/2Lfgdhlkn/KqgnCEFaytpY9EC8a25
	zs0foZKoOzUNMPkyXMc9J9EFAhtNNTN9jnQgk=
X-Received: by 2002:a05:600c:444c:b0:488:a824:fe04 with SMTP id 5b1f17b1804b1-48a98671f6fmr123145925e9.26.1777843697594;
        Sun, 03 May 2026 14:28:17 -0700 (PDT)
X-Received: by 2002:a05:600c:444c:b0:488:a824:fe04 with SMTP id 5b1f17b1804b1-48a98671f6fmr123145725e9.26.1777843697275;
        Sun, 03 May 2026 14:28:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm265825705e9.5.2026.05.03.14.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 14:28:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	seanjc@google.com
Subject: [GIT PULL] Last minute KVM x86 fixes for Linux 7.1-rc2
Date: Sun,  3 May 2026 23:28:15 +0200
Message-ID: <20260503212815.127436-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 39f1c201b93f4ff71631bac72cff6eb155f976a4:

  Merge tag 'kvm-x86-selftests_kernel_types-7.1' of https://github.com/kvm-x86/linux into HEAD (2026-04-27 04:24:41 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 0cb2af2ea66ad8ff195c156ea690f11216285bdf:

  KVM: x86: Fix shadow paging use-after-free due to unexpected GFN (2026-05-03 22:32:53 +0200)

For once, these were all found by humans.  Two of the patches were
developed and tested offlist, but I have now posted them on LKML and
the KVM list.  So here they are for inclusion in the release candidates.

I was hoping to send them earlier today, but a birthday present from
one son to the other got in the way. :)  If it's too late, then it'll
be for -rc3.

Please pull,

Paolo

----------------------------------------------------------------
Three bug fixes for x86:

* Check that nEPT/nNPT is enabled in slow flush hypercalls.  If it is
  not, the hypercalls can be processed as usual even while running a
  nested guest.

* Fix shadow paging use-after-free due to page tables changing outside
  execution of the guest.  A bug that is 16 years old and stems from an
  imprecision in the very first KVM series.

* Scan IRR whenever PID.ON is true, even if PIR is empty, which avoids
  a somewhat rare WARN.

----------------------------------------------------------------
Paolo Bonzini (2):
      KVM: x86: check for nEPT/nNPT in slow flush hypercalls
      KVM: x86: Do IRR scan in __kvm_apic_update_irr even if PIR is empty

Sean Christopherson (2):
      KVM: x86: Fix misleading variable names and add more comments for PIR=>IRR flow
      KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

 arch/x86/kvm/hyperv.c  |  2 +-
 arch/x86/kvm/lapic.c   | 24 +++++++++++++-----------
 arch/x86/kvm/mmu/mmu.c | 35 ++++++++++++++---------------------
 arch/x86/kvm/vmx/vmx.c | 40 ++++++++++++++++++++++++++++++++--------
 4 files changed, 60 insertions(+), 41 deletions(-)

