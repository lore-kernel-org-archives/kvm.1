Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD873DE431
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038592; cv=none; b=dfR9bTjCUST1K3nF2ykCdRoqVa+D7lNuxJS0lTFgocaGW4kdH2t7UrNAEQ5/6V5GvCWp0CaYK58mMHQkqpWuQgNi9sYHveefDRY83nHIFRk/3fSDmr28WBj5KAC0T64s1tannGFGYgVF2C/K2ZojL3oHFkb4TqDtXUif19bprYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038592; c=relaxed/simple;
	bh=Eo81uOdJ+VH0txQFT7CDWDmJC3Wu6IIZvi7ALvkgXzU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=hvypzMrllt63Hb2QU9t7UjBq4M9Gl8yvToljDmxt6KlaSHiXxp7trJWdxHFNRwHt16sMbferQLsafSEPCYZtKrxEbAHFG2Zk9vEaLDaNXmHL8hfFVabjYmNuvP3MWscPn4h2qqh91hvPD+6sDxgy5D6SENBtnNqqEe42Sllt3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajYJdw4t; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajYJdw4t"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so861805a12.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789038588; x=1789643388; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8QbTTWk563brFKzUulM5hzJdIlUHhbe3RJ1vb+Th/iE=;
        b=ajYJdw4teckvPm1NNseabla1HsidOImL0DbGNDMgfy+nS9LhksOvln/KTRyuC2PlML
         BGmBJvnDvf2mEzl/XXGbRisGAXunAFN2FVU5gcyXvcNXYDmvJV9swEdFRoyXsWqaZKzs
         STlZsZCeo7rdyNzeePAUodffnccLCf1WUMvABUQemnP/D0Bo+gE10erJSXZ+QeKUUWPb
         DKNGcpIQPQAOocNzKoH4JuUPAQJz9goxqnpcJMUn+/VYvP/yxHx5xDU9CoHA+TjF1axk
         RHDAoYhYAPlmL8e3drNTe92czh4tQ7VJfz4hEMppUJ04gr++U81qw/Yk55yeaqjoFrA8
         NTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789038588; x=1789643388;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8QbTTWk563brFKzUulM5hzJdIlUHhbe3RJ1vb+Th/iE=;
        b=sQnKPbAmGK26lIzUBNrhkZBhZUVXps2oet5tfjj7Xtbtk2lecO87W+cI+uk0fjaxY6
         33gcZt4SfXeCyBlaaqa+0wBIHEiTItyKh7sriHbDRKvTgLaT2hfr6CG0PR5c4WVZpwoA
         5JyEn5juYdbLtLVUe/ekq7L/rFmm+IMtBaxU7wL5thhG6+mdqixCU/vqQDPcP8NAvtXS
         dxU647ChcfUa/Q58l1tKjP+9C+VC8wS2Nru2h3W1py92wYSbthQ+Pe5jSGcwUcqwbbl5
         FtAvCdlT+aqvwz0oElKUEDG8GupmvWQRYMSALmuXP/5W+n0iKzoj4JvvZpiYYUuwZbTG
         HGlw==
X-Forwarded-Encrypted: i=1; AKwUvBxJ9hwOdePPrWwjZ4oZMy+pNlcGykhcIQb4FDcJ+7PBzzKhsTD5nrpEzNTex6317GLdwaw=@vger.kernel.org
X-Gm-Message-State: AFuF++kRYro3ZoFwv/TloiGfl1wj5mPZKKH+mZYX/sn50GvxvGCQCi/J
	gczeZBktcPGoy6EFJw5I0jmsge9VlN56KaaDJIkaLPOc6hZjkP6I7Ws0
X-Gm-Gg: AYBFou1XplgGiisPJIGGGb3pTyMQY91TK2DQpwnazW3P3ryYjO+SVcbJ3YDZSFDzBpe
	NnWH8pim5d3fRjOUYEMH515arkaETKKkzjbIOwZxoWdoOVH+YpuGTF5D4r8l4lESDcBzNrxlt+A
	21/qZZ5PhnBs1XEOIhWMhujQe3V4/OMaOxl/DgMqXJgFPt3NpZufvm7Dwf2R7v2sv9s5H8mZ8It
	me+m7pBjdKiIe1kaxAQRq8EuFDcJ2raEOyvg3C+KlXef13h9RgSx71zDP8hXR4BYvLjafAMp4nO
	YmfJpP0ibR5aWLux6/zrvMF2zIZPnDS8wcOyITCLv4E4ZcaTN39jpSPVBb4En5UuEuTPFksGcF9
	WO9RC2U5ME6KG4t7Glq9Ssahpv0f+sZdlJJMcUWiCJS9ztsuMWecaPQPuY6jXuuKFCQHbJY2SbR
	NjFrCgu8vIQkYyBINA25+lSWu5icgYu3dqzzz3f++YI0e6vF3pc523EoMqrbg6Ar+FSRlbnadDE
	ofpQDYUARLUwUfNnZxbNAM8rLw9JKb7wg4Bi/EcFE5JDMOhKwvk9pM=
X-Received: by 2002:a17:90a:ec8b:b0:399:1b64:e0d7 with SMTP id 98e67ed59e1d1-39d70bb1bd0mr11082578a91.19.1789038588475;
        Thu, 10 Sep 2026 04:09:48 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm68881202c88.2.2026.09.10.04.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:09:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 11/20] KVM: selftests: Initialize vm->memslots[] with invalid memslots during creation
In-Reply-To: <20260902164123.2546762-12-seanjc@google.com>
Date: Thu, 10 Sep 2026 16:39:02 +0530
Message-ID: <7bkt1hyp.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-12-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Initialize vm->memslots[] with an invalid memslots value during very
> initial VM creation so that failure to configure the core memory regions
> generates an immediate assert instead of potential weirdness, e.g. if slot0
> is coincidentally valid.  This will also allow hardening the region APIs to
> guard overriding a region's memslot multiple times.
>

Sure. Looks good overall. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
