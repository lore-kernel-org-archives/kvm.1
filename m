Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ADB36A35F
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543778; cv=none; b=jnXzRvOPdMzBT339SrMPW+ZOW9R2lrBlOTQMO45t2XaoB2loNDJRCK6pxDyphk9450MU5/+rHRU67kgSgNO5XUFw+tY4sWTezCzrWJa8rGZWTl9pTg+k7JAOffquM5yD7SuhJHRDnzGCUDLy2tm8VkX9Kq+3WEyBnJ0KB2P5ntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543778; c=relaxed/simple;
	bh=uhJJu2sViOipR9a5Qsb1geMr6rsuIpzzaV4wu115wnc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VmzFPxH4P7NFnxPdR5R2POuphE7iCExd7LY7j0YNwR/5iuE6PT0Fwqc0dKSdCfctFDtVSRAjfnHsZo6CoMW26A/10aZYWQ1JFuFeQZxyxuBBYuBIDm0liDcgkvd7zW5dNnL8beDVXnkKl4vDCCftHHTunNt1qx1R33oM/GdZn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mU/8CCvy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mU/8CCvy"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8291230235so1673630a12.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543777; x=1779148577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jY/CI1emJnWJUrMbY14/x8c4oyuxC6FFn11+TJQjNkI=;
        b=mU/8CCvy38iU3nHzXKrap4zaEyh74QVla1dcuX0skA1O5VYR80Rwrfqn4J62fuJhjI
         omoYa53f5dTF/byKG08rNf2CSh4oJjVdyiXdt8jK7FMHLL3iMuhwalzzG/NGomkLbvqj
         VjdT1RzFkhClI99Ax4FkWm/xJTv+YZyPKi0u6ga3HH/SyWaC0FNHfn89Hv3OtWguYt/Y
         WLt9IU8QwTTVEyHGlfmf9Hv3Y9TFg/EAmIULTqbO75ZzI2ZoUEo7eYWio1pwnsp+iwYK
         O4EVG3g3mBbiRWj/7c8aESnLEABSi9fjuljXDwLOl79orV+D3dI9qkKRjQQNTAQPPSDk
         MATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543777; x=1779148577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jY/CI1emJnWJUrMbY14/x8c4oyuxC6FFn11+TJQjNkI=;
        b=AcvjPnwjJHUS+JDcMHzabAiKVElZMwqeMubagniw8vvmOXSgjEwuDYJXqAwgnXqoEv
         uefoQMMBAtuVOu6ii0ecjrcDy7+yyWUcZSIDYZDkn5kYob9uqXv1gG7NuGM2jiomNs2P
         uWIyiyRtUOJMbsGMx5jfvjCUniRO5UKNV//HOf2VJXMCdtADE8CmZbXnmt0yJwrliIWz
         AtF4Qa67HsR1skcEUXbMmcJKLQEyaTf5uZorZgSNNI+CRLVcGpyp1FXts3jGPQTh1HYg
         B73gYUEoOaMIVrxjUP3z+1WO/GRLHBFfG1iq0L2iA/XDYMLkCaXye+nMTEYkoVG7lTaX
         EUVQ==
X-Gm-Message-State: AOJu0Yz7kOrltuhZKK9a2SfWuP+496deTQnmeHW10MJQfMZb1ZbmxxOo
	DFvj2kdkHPQTQyQdskxTrtJZlyQnQJ7vQqpBcSOfO9DsZ0Z6v1vjx0C4ipASp6B7R5W6HH3x7Ur
	GfXNz8g==
X-Received: from pfbfj34.prod.google.com ([2002:a05:6a00:3a22:b0:82f:b709:3747])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3014:b0:82a:65fa:cecf
 with SMTP id d2e1a72fcca58-83eeb9fe90fmr563040b3a.4.1778543776645; Mon, 11
 May 2026 16:56:16 -0700 (PDT)
Date: Mon, 11 May 2026 16:56:16 -0700
In-Reply-To: <20260102142429.896101-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260102142429.896101-1-griffoul@gmail.com>
Message-ID: <agJsoCzokGcG5xwo@google.com>
Subject: Re: [PATCH v4 00/10] KVM: nVMX: Improve performance for unmanaged
 guest memory
From: Sean Christopherson <seanjc@google.com>
To: Fred Griffoul <griffoul@gmail.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
	shuah@kernel.org, dwmw@amazon.co.uk, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fred Griffoul <fgriffo@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 02, 2026, Fred Griffoul wrote:
> First, the current approach is missing proper invalidation handling in
> critical scenarios. Enlightened VMCS (eVMCS) pages can become stale when
> memslots are modified, as there is no mechanism to invalidate the cached
> mappings.

This is a non-issue.  Modifying memslots while vCPUs are active will cause problems,
period.  There is no magic on earth that will prevent that.

> Similarly, APIC access and virtual APIC pages can be migrated
> by the host, but without proper notification through mmu_notifier
> callbacks, the mappings become invalid and can lead to incorrect
> behavior.

No, they can't, at least not for unmanaged memory.  For kernel-managed memory,
KVM obtains a long-term pin, which prevents the host from migrating the page.
