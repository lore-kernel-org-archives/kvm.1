Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849E387596
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717810; cv=none; b=pQDLqsx/si6ddDMkg436t0uEIb84CD3jA1iHFTQB3l/9jG5BZChHIXJyeKFCp3M+8kenjUheCA8eqdN2Zb3Em+RJmMUnsa0jMCAu1bdxoBgUo6pH4XF8i7AORQuG1I5Jy8ID3pG5kDAYJyvu2SKvskbb3h5B++hvDbhYCd1mDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717810; c=relaxed/simple;
	bh=2TQCEiF5Y/KXRZuugVpD0ZOKr6LVSShqt3Fx7ra9V9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rSoZ5OsYzekM2qtFmV45j9+1OXMMbBHs1139tbEeHhuNzqpRuw7tHXtMfqPKeRhVjXfs4LUFr4eOkeKEEXXDopaSMnskeRh27VMtrs+AHkeSf4OrkNRsQkP9kaSNuj8Ub8szMRi9k/vkBUs4EFZnT+eT8ufHmEuLf+po76NBEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dyDxvdCY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyDxvdCY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242b9359aso33970615ad.0
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776717808; x=1777322608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw/xOa4cMDz+3Y150IRREEsvI8FeQ6LscRd2k8rTaIk=;
        b=dyDxvdCY2dethMRJST9NbaSjEguo0wX4dE6pDuUvhCZKtlJnOaAIL3UeXLkfcM7qPk
         vFW8mR9doxNFiiXoAz+S5PC8+7whNdaAkv8Kx9Hd/Y6uevnICQyA5BrMjSMYWGLmbMyn
         kVbiAxukpMjgj5KbBgRa/qv/TMm565c+PjGf7jPaeTwVCt6rE+UiNKBtCrvy3zuSrKWq
         rLItIBhTJ51XiVZAGoAMQbcCTcLnE+gtwcwiUPx1P3bwOnZtsa3Epvayp07zeT2vj1ye
         suJ9hJjgd0APjq7ouQPZRddbhnZpn0mY/b6ZcS6iVnUnbIXgGMQJIFiIjdx5ButclYps
         sdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717808; x=1777322608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw/xOa4cMDz+3Y150IRREEsvI8FeQ6LscRd2k8rTaIk=;
        b=V1S20FoRSjUGtyp6NP0LQncCaVLOCBjEm+lhtoidScl3Zr1q/+7WO2J+k4g1jNXXYW
         9lMUCq2wgP28su9A/aY1wvofj8PEFSpP0L1l23LEkTYFz42u3xYOF9C7yvBPWfe/qqz8
         kibPmG8/EtAg1DF1bqOo2NuB3J7ZLsi9OJwSurT2HpmiTaYJBRvi1mV/m7R7phKfGBMF
         /3tqoGeFgpVHhTACsb0GvKMnvhVkAGiFJqMLeQ0lKglNbI17S5SpZlJ3q+HSPvFZ3aTa
         F5PrfsrlCvDzD7r5Cg4Cnlv2mFR3pgCM+f9dFPR9xJiwB4lW4ho9dE3QaksqhbF7ULCC
         c+Hw==
X-Forwarded-Encrypted: i=1; AFNElJ/BVXGCWupIv+p/s9FKgrUlYpheLZWieeIyy6RIN25odF8Pl8i1bKVtAYlF6+tVieNSLgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZnCYQO6x6sh9meEzxVc7t4G1RQFVsBeTxQaS5+qzbyqj9Eon
	cvkpIj4JPskcX4vtnhuSYs/OrL61yzBDQKpLUYfoBUJ4q8jOIe75KTSXOMNSVvVIGapQqZW6+py
	14t10kg==
X-Received: from plai2.prod.google.com ([2002:a17:902:c942:b0:2b3:2649:c9c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d30b:b0:2b0:673a:7c90
 with SMTP id d9443c01a7336-2b5f9f50051mr108270095ad.28.1776717807739; Mon, 20
 Apr 2026 13:43:27 -0700 (PDT)
Date: Mon, 20 Apr 2026 13:43:26 -0700
In-Reply-To: <20260220004223.4168331-5-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260220004223.4168331-1-dmatlack@google.com> <20260220004223.4168331-5-dmatlack@google.com>
Message-ID: <aeaP7kPPlyBZE-1h@google.com>
Subject: Re: [PATCH v2 04/10] KVM: selftests: Use u64 instead of uint64_t
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ackerley Tng <ackerleytng@google.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Bibo Mao <maobibo@loongson.cn>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Lisa Wang <wyihan@google.com>, loongarch@lists.linux.dev, 
	Marc Zyngier <maz@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Oliver Upton <oupton@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	"Pratik R. Sampat" <prsampat@amd.com>, Rahul Kumar <rk0006818@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Wu Fei <wu.fei9@sanechips.com.cn>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 20, 2026, David Matlack wrote:
> Use u64 instead of uint64_t to make the KVM selftests code more concise
> and more similar to the kernel (since selftests are primarily developed
> by kernel developers).
> 
> This commit was generated with the following command:
> 
>   git ls-files tools/testing/selftests/kvm | xargs sed -i 's/uint64_t/u64/g'
> 
> Then by manually adjusting whitespace to make checkpatch.pl happy.
> 
> Also include <linux/types.h> in include/test_util.h and
> include/x86/pmu.h to avoid compilation failure.

kvm_util_types.h also needs to include types.h, as it blatantly uses u64 without
any includes.  It obviously works thanks to ordering, but it's a lurking trap for
others.
