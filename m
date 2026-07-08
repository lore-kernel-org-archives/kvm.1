Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180237BE8A
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517821; cv=none; b=nxO+sQ+a8GSnmtJ56Zhv5zyjU+WzdymeoDhQmgCJZt3WRHDlvitK55CpQQ3xpn45hRqqx/9TVwqNGEQL1F433369BDf70IvYKpyFu/5N7HvAKVc2CLHKWqgxqEVeDXIL5glIZw3ENOMCgzrjrMiHJlXEcLgUnDCEZxi8iehs/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517821; c=relaxed/simple;
	bh=ZUfzfufgjJ31Y7uHVmkfFwyDJ0sSSswvR+cTuDCSQLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W9cBOLT0H2UaxTQktvzKmDAOzjORodkL9f4f+twwanpLVvZQFS2mhUrvQIttGzL5ZLAzSb6NQ7XdTWt3hgrk9Wa2lTpIGEi6WvRvbAHJSZTIfjdwCGoZL70jwGGx7r/+oWjTajdcSqmRpdrVt11Cf70LWEJqXjZDt/5+xxT49c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekg91uu6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekg91uu6"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so14884825ad.1
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783517820; x=1784122620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ju8RR0gs85gkVW7Nu9aVEZ9OpFpwktbUMsaRuItgRhY=;
        b=ekg91uu6xsfrql3ZihOtUZgsUJagjnqbGXMKRrj79zEYHsh29yRxNhNi9esDbJlze1
         K+6qxsdD4DG9pSLpmfJHlGZGUF9+Yk1LNmpY02e6RaLny4HSFVs2LkfulbgqdKCYgAO7
         pvo1Di1xreDukBWWn/2JjpQVBF+SXMRz5jefdNDTbgkreJHraFoY6tomKQWAI9ryPtEO
         QeV3o60ZHjh10W4cfMis3HrLpbktThVQz3AqLTtYrzBh/rCQJy5aaSuuMrqEfXFiyzMM
         KdCR2rba+DbcdEY8wj/NMTn2WmYsraBeUeg1SbmQeMphdtUsnGrPHhoghEc+51oSe/xw
         9zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517820; x=1784122620;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ju8RR0gs85gkVW7Nu9aVEZ9OpFpwktbUMsaRuItgRhY=;
        b=brGUF0RIQuIfADtSrw/Qx3jCo6Y8faFLJjdfzHWLAePnMUDYkzltTYFExIiQA33GWP
         ekToHXKYvYZ6CMz0OahXZ2FVfu7fFnfutC4Fo0ZmHE3o6BwAJWz+AhDUQjDR8U/39iE9
         UJ77GZe9S8fAFRF9Bf96rpNoZ2bBsOKKSEWuFXExKJW86KNftdEAxiRdA15JBiwAa3UG
         LtUyklOlTC6LYtdmhMQIgQzUCzWRfFvgRko3M18BmrIOj5shWwnE+G1nVeyfoy4sMurp
         dwNEkfKuYyse2hiT5RXeOWim7CyC0Db+0s3CrWK4M3Q1EzCZs2A+TnbMQ/tVtz//IInv
         Hfew==
X-Forwarded-Encrypted: i=1; AHgh+RrM0UIg7gCIb3zZxurcreFNt/WZPoC7IN8wFF1mQV+dm+XSEO2zAfnAQ/g4Ovckar5hW/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPylV68hcSAWwXk0j5P9gbn9gw+ZQhFSkjYZ1Bx7dClEnZOCqp
	vk/5EcIBb/205v1VR3+h4Q17NihToiWJVrYehbV1Nnzu7iekglel5XAniTTDSc/uiJ29seJmJDd
	VpjhAWA==
X-Received: from plbkm4.prod.google.com ([2002:a17:903:27c4:b0:2cc:e88e:4245])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80d:b0:2cc:db71:4db5
 with SMTP id d9443c01a7336-2ccea461f0bmr28965095ad.37.1783517819391; Wed, 08
 Jul 2026 06:36:59 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:36:58 -0700
In-Reply-To: <20260708091408.12106-4-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708091408.12106-1-sarunkod@amd.com> <20260708091408.12106-4-sarunkod@amd.com>
Message-ID: <ak5SemBa0O0qrfWk@google.com>
Subject: Re: [RFC PATCH v2 3/5] kvm/svm: Introduce per-CPU lock and wakeup queue
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026, Sairaj Kodilkar wrote:
> Add a per-CPU list and raw spinlock that SVM will use to track vCPUs
> blocked and waiting for a wakeup.  The GAPPI interrupt handler will
> scan the corresponding CPU=E2=80=99s list to decide which vCPU to run.
> Initialize both in avic_hardware_setup() when AVIC is enabled.

This needs to be squashed with patch 4.  It's useless and unreviewable as a
standalone patch.
