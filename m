Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA773002C8
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309628; cv=none; b=I5BF42GAvPIuk58L6CmW9FwAJqaMilpSrKRZcUDhBNJz8Z1UCOTXW7/Wc9VLueTqUmWUYe3TOg51YhGfEobAq1BJynPZ7X2sD9v2FezyXhYWcPVXb9M8HW99NtzDVMc/2dcPoyRwOgFsHrCoTbxmaliR3KYNuwQnwW0fy1uD9q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309628; c=relaxed/simple;
	bh=vaDS6XNQUMUuPDi84wd9HFSG8Scz5CNLwlPkibF3DEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JPErjtqeQmjWaJwNpSpGYeUyGwe7JdWi7+Djob0KgQ5+GKUSeiOl/yReUyyXCOKllrk6K1aS1n9JFbwtXnNSdS1ru5Lboa2UbLpfMsTVTWQYJ4jmGqbKnp8VK8MWgwcs7DYWsvBUQVhuPL3+0+g1VoCYUwBT73fCWnoAmUezutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cA2nPkTc; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cA2nPkTc"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1c62f0d60so720711a12.1
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309626; x=1788914426; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Yk5W8YMQMFUnjqW7SP37P8eIRPlwXT5+5U93q8LYb8=;
        b=cA2nPkTcxR26xe3iUdwPzYeikQPcHPUtQl5oHDdyfTtDTEAu9Gh/PaQAEGwIQeGRWO
         4FDu+mUADCLJgxiaplhKBMZ9FggdMfiMhO1GmphQbiZufLoshRKzp32WYRcz4GangQ/a
         K85e6J7iXyyFnOPgIs8SunkI6hxdII5bjACr2OhHB+uc8u28jvGSFyKlvg3T91CRMuMO
         sfirtXlNqb2bsuCuGgHjvLXZMm0GDCxOhJmRZtUR45UOy/A3SdeWHy6xzocXNVtwulkY
         po+h7puKPoGb8ZS6Ku13L55X2Y7+CC1WEUVYdwhdZuli7fEBu/zZkUh7+zov8axfb/MF
         Z9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309626; x=1788914426;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Yk5W8YMQMFUnjqW7SP37P8eIRPlwXT5+5U93q8LYb8=;
        b=a4eDML/xByo0WX1kjhtPC5wekcPoK7MeuiZmDNDxanz0/f+QQHNQcEXlHu6yzgrRce
         GOFljiQPDKO4X1aUfJBm9bWMxxgT88Lbm4gcV2fVLBZfZuVwz46/hs3ptWV+COxFIZoL
         HlwjPvn/3Iuld7p00N6UZJog0nNuWs2NSYIPOqW818BR40b/Ow215mI7ohZ4SOTupkZw
         DfL4VdD2JDPDS5ETufBDdakEG17ijLLSE5bnMhA2CfzNKBQFxAGZpiPYlGEfxZZtKYUS
         l/aEeDRIEh1GQPkZPFtJ22Cm9WIrLZMcuseZ5o+49EMRNy3sYhfPOBaGfmzwKNUUH5OO
         QEUw==
X-Gm-Message-State: AFuF++mGYcmR+H7DYIytDgWGT5cEGUu9ZvbHnuSTkoMwndYeDzlBxUm4
	b4Hoi5jwnrxO1MvZM2GLGoLyKm43lvgxEkZvrlQ8GdXFYIcbOFlSaSPxybEi+ohZ5gSe0lGhZPF
	O3F1w1A==
X-Received: from pfbi25-n2.prod.google.com ([2002:a05:6a00:a519:20b0:84f:4ff1:f767])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab08:b0:848:5cf5:5040
 with SMTP id d2e1a72fcca58-85ed23e044bmr2745937b3a.10.1788309626365; Tue, 01
 Sep 2026 17:40:26 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:40:25 -0700
In-Reply-To: <20260831144802.834315-3-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-3-seiden@linux.ibm.com>
Message-ID: <apdweRfqt4dTxcU9@google.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 31, 2026, Steffen Eiden wrote:
> Allow KVM implementations to choose alternative device names. This is
> especially useful for architectures providing multiple KVM
> implementations simultaneously. Architectures providing multiple KVM
> implementations must compile the KVM common code once per
> implementation and mange symbols.

What about tracepoints?  Or do those show up as "kvm" and "kvm-arm64"?
