Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1D1B4244
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361986; cv=none; b=bA4kteBziRxRSiJ0fedvTDHrEiTRhTMQIBOcjIjx1xdXYGntrvLimLBqzw5l+vSg1rRT9lgCoGXx9qd4sN+osD2e9hK6uNdo6d/7WdfVoG5F6xWxJ9a4QZLKZ2Z4HTlyhIwKKFvGgW8aMXUFLnU/JZrkIEmeqboRNFJOlgRPdXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361986; c=relaxed/simple;
	bh=86jgAsKoKBstvpGQH1WPT+KB1h8IPcHXfORgTCF9h+w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dr2rXGMr2wcfkk4ah/wdhVIDQ04dUdxAKN1nFbkbR14GVS9QBnEyRrwrgB/ssMvYIRjN0E0yu8LQBM/aPvXplVodeVssRVcNxhxvhS73yD0ZM8owzr1wyXA+QY6DI8wA7DniG9FhgKcSn10MXo2VWLaf6Y38qWPMBiidZoEuka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4QQQ/7p; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4QQQ/7p"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aec6c572fbso56612285ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773361984; x=1773966784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omurYY7uQAADQZr1TJWl8eTls+fJIixNwL4FOpsEdBk=;
        b=f4QQQ/7pJ3PzmAH7Z4SHba99+wRaro4hiOiOzwetDGRkK5oVvhYH5g9LxbAMILhDcl
         woeKirJRKIclCb50NOnJNOiudAYwhiCExxcgdDE8MgGswvND2zTSCXNbl5VVMo53n1SA
         dVwDblg2u2cU1gyV+KsabJfOiKBVScIS1m+NlK733R01CAc+TpKDT9pwhle9/7+sCX9c
         xQShkDzvUEZ9OGyDV1asHGMzG5jTlcS6F0wExwmW5AK+J6LpCTgrPthHFe+mikeoOeom
         98StOBt+boupx6fhGizcQdaGyo8uwzESSLESLhEFlWauXgvPaTNn/mwgUs1ESNgNz3nO
         L+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361984; x=1773966784;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omurYY7uQAADQZr1TJWl8eTls+fJIixNwL4FOpsEdBk=;
        b=Su9YDYzRT3aEewu+tQHHYqqf4LDt4dsv38P3plmQ9vNjhwnmjeuP35/bZe8CieUTku
         qdXVlNYclL/afGS8/aIPExCiw4P0Y0b72pZc67bKx4lP0jI38fIK5IMVCgXeeJGvxalS
         lkWCdHIshNVNXpY/CjP4EJo8thKh8eLe+HdhzR4OMWaqMTippL5Xz9PKMVuKe3RYVJND
         SyU+IrvXFiA70wCRWREg3y6RGq6zzxp9e79Yfdm9fRCkmsA3RPtOaUkuUrCcRGc28nRZ
         hGyH9pz+fv2qEOdxBwNg5dlVz+9KMpGLOaIZF5TZKtHgitaKlrToF3ahP22twpLQiRrr
         X6qA==
X-Gm-Message-State: AOJu0YzpSbM9ydwI5RkMIRJDzBjmer59QbydnRq9geb3Tim/eT8u5uq8
	tcPjZSgUGeheGeEZV3+CBO1gKBaBeHGC94shhOs06d3BFfooB8xShmAa/KlTQGyx13xg5/aYDuU
	pxcx7rA==
X-Received: from plbks3.prod.google.com ([2002:a17:903:843:b0:2ae:c6b5:1756])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f607:b0:2ae:ce8a:9dd2
 with SMTP id d9443c01a7336-2aece8a9fa8mr2390115ad.16.1773361984418; Thu, 12
 Mar 2026 17:33:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 12 Mar 2026 17:32:57 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313003302.3136111-1-seanjc@google.com>
Subject: [PATCH 0/5] KVM: SEV: Drop user-triggerable WARN clean up REG_REGION
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Drop a WARN in sev_pin_memory() that is comically easy to trigger, and then
clean up the code a bit.

*** WARNING ***

The last patch impacts KVM's ABI due to a size restriction that's applied to
kvmalloc() but not vmalloc().  If my math is correct (definitely a big "if),
it will only impact VMMs that attempt to do KVM_MEMORY_ENCRYPT_REG_REGION with
a single region of ~1TiB+.

Liam, I Cc'd you specifically because it looks like Oracle supports SEV VMs
with more than 1TiB of _total_ memory.  I assume that's spread across multiple
memslots and thus multiple KVM_MEMORY_ENCRYPT_REG_REGION calls, but I wanted to
double check before potentially breaking userspace.

Sean Christopherson (5):
  KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
  KVM: SEV: Drop useless sanity checks in sev_mem_enc_register_region()
  KVM: SEV: Disallow pinning more pages than exist in the system
  KVM: SEV: Use PFN_DOWN() to simplify "number of pages" math when
    pinning memory
  KVM: SEV: Use kvzalloc_objs() when pinning userpages

 arch/x86/kvm/svm/sev.c | 51 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 26 deletions(-)


base-commit: bfd7f4adc1230373c25e1b787a6f1ee407eb0656
-- 
2.53.0.851.ga537e3e6e9-goog

