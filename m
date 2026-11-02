Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633674;
	b=N3OpRtkdMWjfBc90dlweOQ6VVBkc7fl2CyafNMOZF9fwCLDpcPSxIr/MLQPCg9tgvMGO
	 snG3u9RNWrfR5Z8IBaCVL3wOT0M7YI/VeagkCQfyHpgrNkE9fmA6GzSXQclTfOBbpSqVG
	 czwcFWepEVlrd68zKMJd5ydPmsxTOKaSBaqVhqcPv2B2LmJOqXgCL2i0d1RFyK5+tZnRQ
	 aQgbrFzPQSjyrrAbE3l+1GdaI1KRXidMP+TkFdkBQju5OQN/wdOWGF2vtuvUxYxpWw6Xv
	 CBQP8TJvI3ID2pB2npDejdFxxWLDflED2ExFAHETSrDRZ8uoGjdhIIOj2YN3XExn4kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=s4vRCplgEoCQN3eUv6q9zSWbIbV1TXU7YJjG5+iZQYY=;
	b=DGnyd5PdoUTz9jpobHvf9CbFza3W+x/4XTX7tJpv7nA4qTe7c6xYfilyspMCOoPMLTuM
	 qxHdK4vrst1DGDLQPsey8IO0yTWdDu2+yu4Y4wtHdF0dtXKgsM9ZY2OaJyPbqivZZEJC+
	 YbUil5vMh/PB77akMoMcCrYgcTxgimgw7e3Sj8Hh8Nz/SX1ia7LHdaLWCmhuPkN9myUX/
	 7moms5o1aVaNKfQcmPiipMxIAVtIkUSd6jtLUKhGENJFea6Umg2u9rMcasOmy73s+4NY0
	 7Kyz7+/aAKN1Wo6GuPciPGaJ2IKVvdU8HxHzai1SNAaCs+nq8O6wFZ5WhGOp2JKf1eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kN4K3wOz;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF708606B0E5
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF708606B0E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kN4K3wOz
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac8f449d1bso2537075a91.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633673; x=1794238473; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4vRCplgEoCQN3eUv6q9zSWbIbV1TXU7YJjG5+iZQYY=;
        b=kN4K3wOzdV/W3kh8g+0fWAyOvSiocNX5hF6muy3fNL2kjHr2M0/m0NeBbA46ErY+rZ
         4lwnFHaV76Ds1818iOmiumDby839pjrL7KUgmytU2s2ruLqPCQEdGMQiahueohZNK2CQ
         aZz+3LuceSS/uv0cOYZMcLdkxRdLklQru/+a0zKfV1/M0IkFBCMCos7Aid6/1xuPJPq+
         gC2sptDx87uD98TtLWKiqixhLdtOVmTcNXsElhyxVgNyyygHKGSpa+ZJ8/AGPxIhXEPm
         ORcsu3pZVRWhuMiy9Pfuo/mA2BsZSMU/dta3J0iquXF5cMKuKDFP9NnK0pNaii8py6jp
         HsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633673; x=1794238473;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4vRCplgEoCQN3eUv6q9zSWbIbV1TXU7YJjG5+iZQYY=;
        b=S+Wlm0s8Fvts1S+FeiqGSxYy72nkXLo62g9F/RanwbQZIwtY0TiKCxNvoBUNJHWJug
         innrYTBexyh9YqZjst3cgiLA0afBD7SNBbsGlZap9FTEC8uWdM65jFxm5i8XohyEtfUy
         TnoRaib7iLM3S4UBngxd2k3GGGhCZx2jASTrIcxRXOr5NMYUm8J3KdNA4Q+9z7IACTy5
         gWY3Xh9Ylrcv+l5xr08XmKOJuD6jKQE44h52QGPWeP2UJzWkmBAzOFflPYfD7uSl4c7f
         OntMM3lKeeIkEY1gJNN59Xx+4wZQ5Wbzu1sRL/bcbhglVLGno6dO61opzHBuPbNSampx
         oTSw==
X-Forwarded-Encrypted: i=1; AKwUvBz/TwMoYNMJEbt9p9z4mblmjttjGIx+GZ7dWM3FMEM8LM8Q5Q9TmbRC/cm0RAuW2HtWeTA=@vger.kernel.org
X-Gm-Message-State: APuU4Z//zUt56mqT0+ExQa8s6mO6tfZlEkjIRW75BbA+9nsuG2QMLiZA
	0itDwK/La0dyHcj9c4dF4f7D99MrhaNQomiMApyXhVyBm9/DXNND8T1SvfxwXHMkDq1+PMOdFZp
	WzrnEpg==
X-Received: from pjso1.prod.google.com ([2002:a17:90a:c081:b0:3a8:211b:6c8b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2749:b0:3ad:43c1:7d41
 with SMTP id 98e67ed59e1d1-3ae897429b9mr7590262a91.33.1793633673063; Mon, 02
 Nov 2026 07:34:33 -0800 (PST)
Date: Mon, 2 Nov 2026 07:34:32 -0800
In-Reply-To: <20261102153228.240804-H-seiden@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028190259.1819571-1-seanjc@google.com> <20261028190259.1819571-2-seanjc@google.com>
 <20261102153228.240804-H-seiden@linux.ibm.com>
Message-ID: <auitiPKnFueBJzPA@google.com>
Subject: Re: [PATCH 1/7] KVM: s390: Drop unused and unreachable kvm_arch_vcpu_should_kick()
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 02, 2026, Steffen Eiden wrote:
> On Wed, Oct 28, 2026 at 12:02:53PM -0700, Sean Christopherson wrote:
> > Drop s390's kvm_arch_vcpu_should_kick() stub as the one and only call site
> > is wrapped with "#ifndef CONFIG_S390".
> 
> In the somehow near future I'll remove those #ifdefs and use the kick
> stuff for kvm_arm64. The native s390 KVM then must at least keep an
> (unused) symbol at hand. It seems that the compiler could not optimize
> those calls away. So let's keep it there so I do not have to re-add it
> soon.

Please read the rest of the series.  kvm_arch_vcpu_should_kick() goes away
entirely.
