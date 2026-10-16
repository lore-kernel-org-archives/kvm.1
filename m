Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D932AAA8
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112967; cv=none; b=rfhKS8aiK3bpYW5rMvpHbISxHe2CyZf3aAcflypBW/0x9dUQnSEqrYFHaNTwCXVEzTms0lkUafX85LsEQIE+hFdmgKYZiSIR5N0C+ZZTlSG1jWzHucIRXA1P4P7fr3rvDbvCqVyixYXSQw95H3oU5iFDMx7Y2DRoXRM/u5d1kbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112967; c=relaxed/simple;
	bh=Fnap2Rx62fYsbiLE8UE3rOQY6lE5SWcRUsRCoHhTdNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ew6orX8zTklJLJqUvqTRXV4pPEnNogfmCBt/rm2k546MjDmmCX+5b2cjksTYYbegZs9dvozxEe3z28sW7gCCDqL9vMhZPUdLy/2AY1aCZ6o98b4ayPRCuyEmuDjujffYu2RDikLJFpwzePQpwUCKqEM044SDd7SHRQqqKDMw94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I97P7zEP; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I97P7zEP"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd0e92d64a1so514514a12.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792112965; x=1792717765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8LGdcJ3oqZPjHIrBM3BmFTUe/r+rIIS1a0NntXDK3pA=;
        b=I97P7zEPnc6uOCizd9gyJS15Fgnkb88wz+7QVTaCe1+pitOR8wjY8hR594Wn2EB50w
         tnIoNnwa1+r6i3JQ+zJa7a4d9WokSW0dI6AJ7YQtn+0CkkW+XauLzR1+8qn7Foe3bXfK
         KobL3Tkq9afWfgkncqGWznFRYIzjTpCrlWV6BldeaLZlyok1hflRVL5I7CsgUWq1mufn
         lYrfdL4Mi3dd8Wc5piobaBtFLTj5V2R05WYKrWzBN2WuZNvzJ2wodM+T71m6GbuhjEca
         sXlYZ44zA2/BBfcqKe10eDHmkcBBjaH90SwCNHbYyM3F2MCoUf5s/5pct8dLIqwwfECM
         rBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792112965; x=1792717765;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8LGdcJ3oqZPjHIrBM3BmFTUe/r+rIIS1a0NntXDK3pA=;
        b=nY6Y/nwnJA7KKbXteKRdCMOG06w7LgYvXxV6UStkVQ5/rl3T/B6XHbkcj3Me2gdPYa
         kbsLh74slR9UzIOYggTI1bTnHqdDBH94OjaOznmqDPceIjX36bXhmDGau+h6hmxNw/L+
         G6OrCSB6vHRuBHVVJlyra/oDQl47j27afCkrThulRbWTblSMJ8+7oFImIJG6Z6KBKlx1
         Zp/b88266jHTt3SZlp5emAm+I2jsPAScFsEISfYCmCImDzd5TacVrDaTFImYxw2FIU9+
         pPDUqQoqoNnAKcN6F1XhW86ToNBhBi+TU9iPvo0zZu4CjwSyGEuouU+83kDeZKNLjqOM
         d9EA==
X-Forwarded-Encrypted: i=1; AKwUvBzNH5cdfnbxpbg1UdHu/CS9GahO7DquZcW+pvqzfgxyCButkKk3hS/0aKkJLKH5rqc41U4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWv30WDOo2GqE/Doi8vep99edNoal9P6GlsiSzQWmyleC2IaF1
	E/CSgpLaEdjh5r9rChiPUk9YajJ5J7Ry2OsqwitOcKTbONf7/ua47eGlvgkC/4WhkD82VYwSElV
	r0DEZcQ==
X-Received: from pglk22-n2.prod.google.com ([2002:a05:6a02:6b96:20b0:ccf:9d14:abe0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:394f:b0:3e1:3734:63e0
 with SMTP id adf61e73a8af0-3e202037737mr1140181637.41.1792112964479; Thu, 15
 Oct 2026 18:09:24 -0700 (PDT)
Date: Thu, 15 Oct 2026 18:09:23 -0700
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
Message-ID: <atF5Q7ICoyOArbRL@google.com>
Subject: Re: [PATCH 6.18.y v2 0/6] KVM: x86: CPUID faulting fixes and AMD
 CPUID faulting virtualization
From: Sean Christopherson <seanjc@google.com>
To: Anil Altinay <aaltinay@google.com>
Cc: stable@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 15, 2026, Anil Altinay wrote:
> Please backport the following 6 upstream commits to the 6.18.y stable tree:

Why?  These aren't typical stable material, especially adding support for a new
feature (virtualizing AMD's flavor of CPUID faulting).

> 1. 690dc03859e7 ("KVM: x86: Ignore cpuid faulting in SMM") [v7.1-rc1]
> 2. cf7d65d1d6f5 ("KVM: x86: Consolidate CPUID fault handling for emulator and interception logic") [v7.2-rc1]
> 3. be7fd7c3e8bc ("KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX") [v7.2-rc1]
> 4. d1bc99885a59 ("KVM: x86: Remove supports_cpuid_fault() helper") [v7.2-rc1]
> 5. e93a93f11490 ("KVM: x86: Virtualize AMD CPUID faulting") [v7.2-rc1]
> 6. b16c2aca369d ("KVM: selftests: Update hwcr_msr_test for CPUID faulting bit") [v7.2-rc1]
