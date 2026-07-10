Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433626A1C4
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783659996; cv=none; b=ljBpr6z8eNi5MwRymV6h1KrAKqB95QUTnBlshcMc7VmWpvMOoq0fRH5uabKzXG9wA/WtD6dtvKYG+gfH6Hr7umrz6ThavXvjlK7gvVaQayuG/JLE39lOIoyvdufxbuUDbD062wAo8cwHwN0DwSeHGuwLuii1cThDnIujpTmQANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783659996; c=relaxed/simple;
	bh=tqNjoAgnA9FBPaw/OgwTVGIEq2ZEoyk6fxq9pWfgyts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQZrnNv+1hVxm5QRJPNmegnTwPzUI4ltUShhLpnLHtDBCDNbhDQO/WGOIpaAhlcya535QTKyqSUUj+3tgcxORQhpJgDm3CinJA8D7E6XF6ZAj38eKPefPXp9ktiBn5fUjMJfGd0xeOtAXXd8+E9U6r5aGlpc5SyqflDMij5/7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oga1ocQg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oga1ocQg"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so4926615ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 22:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783659995; x=1784264795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImNIiwacby35FVtPkvIxY12uGz7n2N70CkNy2HlFDRQ=;
        b=oga1ocQgkwGiJFx//QKQF4V3Xud+5fOmk1Kj7EK7FYSsSrgHIo8Ax0fvnQNsZCZBS4
         wJPcOv+DADcNg3+BwlzcYch0uYiDHvcKPMsi4eKAJPNEoFVKbBNkMJRBxMobm+qcoBQA
         7N48XWLi/ds5wb6kU2q3dRXAYGqhL70ze1IXMamW2vkc7LhwQavIfUEo13F61OUsPFtO
         +tk53z+eoGCSL70mPAJM62wHMH+ImkdGqr3B0G50A0A3osbKeiecg/+KIjfmHKCQBSiS
         QyZm/WdGmLs/0J32Sce5hVy1lQacDti46o+gVr7PaT0lWh0OQaPTSH6rghlKbV/9MFic
         +P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783659995; x=1784264795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ImNIiwacby35FVtPkvIxY12uGz7n2N70CkNy2HlFDRQ=;
        b=I3pP7tb1mM1YuEDMaYL2NbVNzlnEUi5nMvOpB07aYj5A484ppHtD1crDH45X0KsD9g
         BfPjQfuUvpJMUbnvbtRAb98/zYBCMhO2doABDD49s2uKHG76f/4Z3stlEDB9R4H+tmXa
         6KcweYstbkuk00xR6G65WkP/48Ikloqr320mmsk+98Ed1Z9z/ivRHS/PnI8jArkY/Cz/
         lIz/b/24RNQHsEuJZq7Ph+OQJ+q0tWr0p0F4k/gsSF1q5yd/RjZYID0o6wH1CWkXLH4I
         VF/5agvbJtT1c4MHYtsJiqsfKP+XiDsU3dkqiOj4yCHIn09pt0RrAogfvoJhzCI8jkCh
         g1Jw==
X-Forwarded-Encrypted: i=1; AHgh+RqWBchNLZtoCjBjyUlsMGGXEU7Z+6SdrZCodMP9l9s1JKMz5KgtqqAxd/cVJvfIQ64N94E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzog63CSGCkH0GHljxsq1iQQnKkVQOVh1EN9UzSr/fRyEtP2zog
	m9Sk73YS/LnoGqdPJsuzHXA3tV5SAJ9QTApK9EVLRKJWsCXGdtIKN+kE
X-Gm-Gg: AfdE7cmwRfTK/PTaAFmFY8LBUD+gFYjUOJsphJI79zu3ySIJeCtkR5YAY2YpwVy8Y1M
	qhCjjeOTs7GqNM6y0OCwmvSDCTfUsn476ted/irVZ+mE38Hucji+rdyYgioCSwqC8/tsVORWI+c
	U0bGiUhN3Nw1ZO+5s2pPLyOQTkOiWMRnM7y4G7S9c18oXYbV4JbK2iBG12b4XixdFKkhTcrHtLs
	+p4A86/0gq8ic6tPL9HzAj+0CUxVZHTTQc+YHzP/fGVLXIcOr6Qm98vVPywoFsNDuhUyqs+G4v+
	Pl4LWkjLqZoiMDke6vL7/KtZK48WVz847nSpBDNL1WYKoiYGq98B5lbR+RBCOOiWIdlLvpY6omO
	o1wpJDZ6siwuin9mim4tvXuPPC0ksDej5MiPKMnWCC7bkKupq+cbTNVlTCNor+bMv2govxmWiO2
	gJkmEPd55IoNh4syAhpSKGgiCyNGRZv85+Pfo=
X-Received: by 2002:a05:6a20:158e:b0:3bf:ee42:195 with SMTP id adf61e73a8af0-3c0bc90146amr11909587637.11.1783659994980;
        Thu, 09 Jul 2026 22:06:34 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c865asm38752224c88.11.2026.07.09.22.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:06:34 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com
Cc: pbonzini@redhat.com,
	shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hemanth Selam <hemanth.selam@gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: selftests: SEV: Verify unsupported VM types are rejected at creation
Date: Fri, 10 Jul 2026 10:36:26 +0530
Message-ID: <20260710050626.844624-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260709174955.628913-2-hemanth.selam@gmail.com>
References: <20260709174955.628913-2-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026, Sean Christopherson wrote:
> Literally every test relies on the kernel to clean up fds on an early
> exit.  I see no reason for this to behave differently.
>
> Also, Sashiko was wrong.  If KVM_CREATE_VM fails with something other
> than EINVAL, the assert will NOT fire, but fd will be < 0.

Agreed on both; dropped the manual close() and the errno latching.

> test_assert logs the errno, no need to spit it out here as well.

Removed.

> Heh, I agree with the comment: put this in a separate selftest.  This
> doesn't have anything to do with KVM_SEV_INIT2, and in fact doesn't
> even have anyting to do with SEV+ or even x86.  E.g. add a
> kvm_vm_types_test that attempts to create all possible VM types, and
> asserts success/failure based on the output from
> kvm_check_cap(KVM_CAP_VM_TYPES).

Done.  v3 drops the sev_init2_tests changes and adds a standalone,
arch-generic test that walks all type values (including out-of-range
ones) and asserts KVM_CREATE_VM success/failure against
KVM_CAP_VM_TYPES:

  https://lore.kernel.org/all/20260710050442.826777-1-hemanth.selam@gmail.com/

I also dropped the "SEV: Sanity check the launch measurement" patch for
now; v3 is just the VM-types test.

Thanks for the review!

Hemanth
