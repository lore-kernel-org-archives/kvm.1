Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97D913A3ED
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783385775; cv=none; b=ik1K6EM8zR1VNukQSVvT6AetZDtci4qIhODrtYYei782omNCCgQehaL3LgCReOPcwm8W6ROX0uxWK5kNWfuhKU8wqPmsIlk932oucuFoB7lVW0ecJz2NbYX+9Cu8BdFfrCgla55a5tGC9qvnhfDilYEOSHcPmY//VliVhz9B8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783385775; c=relaxed/simple;
	bh=2ElyoNTjNvCHsolLm4ZPm+IBRz5WRZTA02wMyFsRuC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P0Lrj3r+V5j0fqL20b+n/Xp/hv21Ijk7b9K+zWDsMdP/Mnca+GxMLbFDl0g9vF4+upNsnvheDCbAR6TdF7uZ0G/ZUu33oQPrNXWGuL7pouDj5llfw4foiKdoGa9EWD1ttHrDoV2Im8HaxSxU+K0esN1Ieo7bVKRYocD+9IBMV6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cczxnRbq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cczxnRbq"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9ed5caa3bso1844445ad.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 17:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783385773; x=1783990573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxNhNQGund/YZNpVTOrvdeVh/HxeApY5VkBlX3NJ2Bs=;
        b=cczxnRbq57sKEHDeH0zAdRygIlj833Zfxvd8UmiCvCWfODHQuWJYtP68qS4mL5BVv/
         Cl65fWP7VgcPbnTyYphZcp+pC81PGb1GgQNdGjM/jNCopIips9ud4ywHF/81lpTRMfHR
         o/6JWSk+uOAyPQPf7yoKRllvM2k6O3Q6EupVqHqryw+Ahc8AxwlX/kqZR/EQwlEn8F+G
         7Dvzw2oV7D7Yqmw/HQbgLutj2VWZ3oiJlC9RzMLp2Gs74wG8FF+TPCZJFhMvEOCv3l7L
         6SRTl0WR84yIHI3jqQI42qV2TUdQ9b/QwIfLqK6jp/TUTRTq4kLmvsWOpEEJrpAcct06
         MTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783385773; x=1783990573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxNhNQGund/YZNpVTOrvdeVh/HxeApY5VkBlX3NJ2Bs=;
        b=Piqg19x4i8mvaTh1dSFRbUjCUtrsuxUMdh0f+u+tAtMmKcvJScNmi3qKgo5Nr9x3lZ
         DtKP/PEEtQ6gvP8eeD1hlV5tORMgFsrbydiDqvtJm7jeCbXVLVjitURuiaZj0X8cSkkO
         Y0KWjhLXTCAmHv+Xri5T+LHUOlHGHHZUb74lBlxOENNzOWvlSu4EN5cRsAhxACQ5CDkr
         oQqZx89+Xg8oKLaU/k6uDdzwZR6AVQN00fL5bGNVZVbEUxmoI0pbvhzzkV6j0go+InWo
         7RbzmmMzUecxAqNh8yK6RLvWuBlElTtlQY40gvWSESt0T8cLG9KH0AedRiYelVhLZHGB
         KglA==
X-Forwarded-Encrypted: i=1; AHgh+Roh1cRTMnfBth8lKz8N8l44fkFTWKBnJBO2sIeV0qNe4fxE6MAGwzSa+vyW4uS/lEqW9U4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6cKpQV7MOMEigE5PxG6qXckuZYqUVKiXeoY4KttEIj6sL+ar
	dc89aFKSfblkQ6ETYOOe+AU7MIl+GkiBfD52UcprRWXZFu74QfGyzzvY34BQ7kTN5VTSFnIFWwY
	7D5MUeg==
X-Received: from plwg16.prod.google.com ([2002:a17:902:f750:b0:2cc:7ef7:ea41])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e883:b0:2c9:fc0d:165b
 with SMTP id d9443c01a7336-2cccade45e7mr5481825ad.23.1783385773032; Mon, 06
 Jul 2026 17:56:13 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:56:12 -0700
In-Reply-To: <20260702142912.6395-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702142912.6395-1-alexandru.elisei@arm.com>
Message-ID: <akxOrMnlNga-vtQv@google.com>
Subject: Re: [RFC PATCH 0/3] KVM: Dirty page logging for guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, david.hildenbrand@arm.com, 
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, seiden@linux.ibm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	fuad.tabba@linux.dev, mark.rutland@arm.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 02, 2026, Alexandru Elisei wrote:
> The memory represented by guest_memfd-only memslots
> (kvm_memslot_is_gmem_only() is true) is shared with userspace, which can
> freely mmap it and access it. The only thing that is preventing dirty page
> logging for such memslots is that KVM doesn't allow slots backed by
> guest_memfd to have their flags changed; they can only be created and
> deleted.

Please (publicly) document *why*  you want to add dirty-logging support.  It's
all but impossible to review new uAPI without knowing the use case.
