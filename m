Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209544399C1
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510548; cv=none; b=ojhyIiTTJQQxIZhaqdKaP9UiGo0k/1HP7POSCcdXoJxHwNdQ4uFi2Jrp03F5GaxLhrmX29MnCWg3GIfV7Jmy4Q8F+7HBAwZyab7XVDgvO7KCDNZkW6PB5hzymXbjR4esfjinLwtMgZWxUXHNfu/4EEaM9vIZxXnWLwTnCGgxvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510548; c=relaxed/simple;
	bh=O14zjjovGhUS1oisSmIPImyZNtw8PEWRZRj6BhjFqXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3IiA8ywfIaZOz+1iqHL5lzYcXduzLY7QJ7UNGcLGLFZSQzZmHzgvHHSAHsFh7wGu/FReDa5sDbgapS5qyN3KQFc/tRNGWcRnlykf7vuBc2r8pM6AkA7tPv1EShhMexAFqZn1nqEKlLtMP3nmmDLxpxvOJLw3thWill98ennZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z4Lm5Ch6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z4Lm5Ch6"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso720164f8f.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785510537; x=1786115337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=flDxck68r8K2V0lreAAuQvFuepl9jlGM1LdPTHPMSDc=;
        b=Z4Lm5Ch69LK7n5bZYSmYZFGQD/6rLOOhEYUWoND+Mva8bO5aq7Q7iO6B7sRJAJEIS4
         SF024u0dr3Oz3xLQe16c3y+TpNb72aQlMT7lsSBCRnPq+FNQNoEalEefnww+hmGG0WnY
         ZkbtRZgpmjiOmHZrjkZDm/wQSKQdyQRDDH1LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510537; x=1786115337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=flDxck68r8K2V0lreAAuQvFuepl9jlGM1LdPTHPMSDc=;
        b=GHoqmNJyo2mhKM1gdECicDckpAz9gmDXhv4oWa1/0HrLilhsZ/c/b9KXE7uek5EgNc
         TVHZY7bHOkpEsshERIkW+34N04ZCf3asIm4zAEu9Owi6pXhT6NQjZ2ML5vOkez8X7Ebg
         ovu/lVwTXULQzC6djW5IoBsIh86aWVnLjEuTU+ZX8kP+hZs10nSDsrETosjWHzcOdeZz
         soUEeaHTOG77lNcr8dNiwLq8WEwQed9muzgq9S225Mmvoxh3sl9id9/IJM8qsJISd3XS
         +guVBulp7USC75f5UgSOctxB3Khe7zPz+nZM6YBxKxnprkofHXGJ4T+cNGHUqXhmdqRS
         COXg==
X-Forwarded-Encrypted: i=1; AHgh+RpioWSVXCAKNbjR/3h8o0+gAkkEirzkWfOHccFrgX63QT48NJR/8EOF0M5jFvYOEgYF0G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQU/fjNEm4UbIr9bYAgIMw9utDhzV0vUvD+BAa/f+4sstGwjcA
	iR1fb+NidbqFLNGz5a6+d9aeXNT6hLo7y5+NduNAhu1vIGGg6QCMbn4PZ7165wtA6Q==
X-Gm-Gg: AR+sD12pkdBU+8QKmPyg6MFvBVpqpxPohYV7G65jbxRc3uK2OOKiQ2Krvstp2p/XgKD
	9IP3seFiOLAneVgDR8n0/Ev6Nq4+7vtUxWJh6kbw8YtxRLZjPuE6W7qHrSQWH12F+OLMK2ob9Q1
	Mx7grgV3BwBBP7lbfi+/riNs5IIvZmS43YvUFhlbVJRAgNXgMDqFaJSRdZtu+R1LY4FLpgBKRSC
	EncGQ+fV1KAtpSb0cdAF1z7Zrtpy6D+7A/wwh6JKO4WDLOjZIw9O/onE1OaTuiPpZTWNxcCcDU+
	ExzXLpMd2oe9Iz+eo+oAGgA2na38yKPHFHlZgvUfRlim1iHb+N1Km8Ms4gbBMrNi0hFwhBT27bc
	vfxDC9SEhBpZk9YOhe/qfP/5m0111pLP9U9iPNR4up0EpjVYrM/j7lEtZGFRVzyHN8e512CtAMt
	F0PEem4buubTCBME+LMWLKCrkjJs9w75nC5Pxl+pQybuHz0S7B/6BE5X2boX6izW+qr07qNAguJ
	GfYIFMc4OTCVPvs4A6ZDtXw0haQ/9/CzzzHmFlySNoKtIfM+PX8rY0=
X-Received: by 2002:a05:6000:46d8:b0:47f:4dfc:ca1e with SMTP id ffacd0b85a97d-47fd72ab3dbmr35826f8f.5.1785510537114;
        Fri, 31 Jul 2026 08:08:57 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm5647974f8f.34.2026.07.31.08.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:08:56 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@grsecurity.net>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v2 4/4] Documentation: KVM: Clarify that KVM_CAP_MAX_VCPU_ID is exclusive
Date: Fri, 31 Jul 2026 15:08:45 +0000
Message-ID: <20260731150846.1728164-5-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260731150846.1728164-1-dmaluka@chromium.org>
References: <20260731150846.1728164-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM_CAP_MAX_VCPU_ID capability value is exclusive, i.e. valid APIC
ID values are only values below this value, not including it. Its
documentation doesn't make that clear, and even suggests otherwise.
Fix it and explicitly state that it is exclusive.

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 Documentation/virt/kvm/api.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e3003a241d5b..dab9a28c0fb5 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8593,21 +8593,24 @@ KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT        By default, KVM for nested SVM guests
 
 :Architectures: x86
 :Target: VM
-:Parameters: args[0] - maximum APIC ID value set for current VM
+:Parameters: args[0] - maximum APIC ID value (plus one) set for current VM
 :Returns: 0 on success, -EINVAL if args[0] is beyond KVM_MAX_VCPU_IDS
           supported in KVM or if it has been set.
 
-This capability allows userspace to specify maximum possible APIC ID
+This capability allows userspace to specify a limit on APIC ID values
 assigned for current VM session prior to the creation of vCPUs, saving
 memory for data structures indexed by the APIC ID.  Userspace is able
 to calculate the limit to APIC ID values from designated
 CPU topology.
 
-The value can be changed only until KVM_ENABLE_CAP is set to a nonzero
+The limit is not inclusive, i.e. the maximum possible APIC ID value is
+args[0] - 1.
+
+The capability value can only be changed until it is set to a nonzero
 value or until a vCPU is created.  Upon creation of the first vCPU,
 if the value was set to zero or KVM_ENABLE_CAP was not invoked, KVM
-uses the return value of KVM_CHECK_EXTENSION(KVM_CAP_MAX_VCPU_ID) as
-the maximum APIC ID.
+uses the return value of KVM_CHECK_EXTENSION(KVM_CAP_MAX_VCPU_ID) - 1
+as the maximum APIC ID.
 
 7.33 KVM_CAP_X86_NOTIFY_VMEXIT
 ------------------------------
-- 
2.55.0.508.g3f0d502094-goog

