Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79646D574
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041929; cv=none; b=RqI1llf9BCCj39rxonU5n9eFN5zRu69TX1VhSI7jl8xx2MlwSLtwL0Khq0YH83wAmSH6IYQMLs/x1O4QPlxOGOcHw/Wnr/225+HCIE0Z4eQKlbZ1zK2JHgtQJWyuY6OwuuDUbkix4xiBV7ZJAwjer9rBCvyLQVKkotcbPx48eEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041929; c=relaxed/simple;
	bh=DthyWf2+A2G2Y75caLR9paCIYHUzGrDRbammkA/3Uc4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ESOxAQwMGEpMqRsA/8rknNn30AH3FEPRQZ2qOpbTIRyQkgMBC+Fj0e0uRO0g4RlPjbxq3wY3+4g2CDJuVpH1xAaZ6lCx7BmSa5pH17EUYlWZaxbB0eWNrc9uYonYwhX3RilSe4dD+qJVZOR0iguB0M8s34668hHjR4oGLePIRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYWA8wvG; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYWA8wvG"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so893141a12.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789041927; x=1789646727; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=j5p0fnZhfsutRgdRJoA23rs+n3VC6+9xK2KvWtfvI90=;
        b=kYWA8wvGeDud4JwysGNjSHcAcd9wE2You1T7agnFoW6lVbpLJkeQE7xg474UwTmARN
         VkrCyzPBwiJYVncpCLOedeaSI4XclxDvpfgMKqROnPc5iXzk+kbtosbkjx5olJn+fI6n
         A8lxZFcY4Oviqe3vojSitjY0gVuJQWfTuIQ7lz5DooTciw6jFxIOhzDasmWrMV16NHeD
         Yd/mY3WewGasK7sHNga3trwcWzjMxc4kQVQAYXCr5LQAMFyLAhRXvBJg8+jivbjp4h8n
         xewoj7/bGexSpKe6+fL8k6Uk1BnWCvNAvZZ/++hKIk1lAv/zaWTG7lQeo1mpnVi2dP4N
         Frog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789041927; x=1789646727;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5p0fnZhfsutRgdRJoA23rs+n3VC6+9xK2KvWtfvI90=;
        b=FltJgfcZ9eAo58EBiq6e7ClXP3XSzNGDUsgK3EzI41WijadK9heSe4XS777gnTVnhG
         uMgGuOsjgTeCM3nGFwOC7thBie5i1nBfiF18OtHxlCkxyHFCr+nPoAv0bJrok5A38eli
         zyf5WkMG2wstoWEkqziHoc+EaFgopCmGmHcy1H+E+800zxt8LGRxOlUneU5RNHcKUVf5
         5ie6uragWFXtf0rK+k89YXnWda6zXCSA6Rj+0z4XJW5UzDvGP+eHja3mj5md8NrwBOtU
         FKggeckE/P7GTR2vHOB1zthz9DSnPWfG4CEmoEXNMghGs0rP5mPAnSk3VCXQibuH7ZPD
         ASjg==
X-Forwarded-Encrypted: i=1; AKwUvBzmfLn9xxF3R3hnDlmmy0Jq6QO7tjNrba+UzDEEGKbDRlcambZV5jN2wdcYE+anLHP2qqM=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ4BR2c550hot6VvsHtO9UNOllTx8+inTGKwidRpGrE2YLbHEk
	gCACRv0g0g1y9pKRfQHLkXtwR0ZWZMmvXO2XW3XrCXPH9csBTxIh99+/
X-Gm-Gg: AYBFou0prJRJjqC2sTXfiLwROPyrrgzHNblY6wqxsSWDNLa8l2DXCi3zZzno+nMXldw
	SMN2KfuM7Ix3X/sBNc65GoEW6sNW8N7P75OohWk+SVA4jGqBOWmsexfjrTPlcuQ5UTUgCNsf9L/
	HfGzCcyvr/Jg2HmLz4mwHt5xNLs0MwR2Fmve1CYF7G0NbyX3Tzp/XfwsrhxXU0ft5d+Ovzv4UNY
	p0oGqhP3+XcYGpD0vjvTcfY2QRUM1I45uHuXVVOzfT7znxp6bCjYwsbDcV9CCsKlbbLszKtcrB+
	JglwmgSYKGhSBedS5jq8MExgUDWOuT34xr1vqaeLfpagXXf5Pvvcy2LNDqB979TlEeuOKYIFAaA
	qfXqvVRkudVyY1YvSTeM3vLaawhl4+5p+QK3gse8fZLQu/LVUmsdUwoFnPfBriwyNBH3ht6gfkU
	cGXsSdQfegVypurBdJapczIEc3zIm6y61X2kH5QQoccIYTgFdFedvMuc9hfcQqZXeCF8SZEaYKW
	wxDJy91yeEXQ//WwR+j5ZWSl0YFC7KTOvUGEQFyuUa+FfpdiabTJio=
X-Received: by 2002:a17:90a:ec8b:b0:399:1b64:e0d7 with SMTP id 98e67ed59e1d1-39d70bb1bd0mr11567376a91.19.1789041926812;
        Thu, 10 Sep 2026 05:05:26 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm59190560eec.21.2026.09.10.05.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 05:05:25 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 20/20] KVM: selftests: Add arch hook to force page tables to be naturally aligned
In-Reply-To: <20260902164123.2546762-21-seanjc@google.com>
Date: Thu, 10 Sep 2026 17:27:18 +0530
Message-ID: <zexpz5cx.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-21-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Add an arch hook to communicate to the core physical page allocator that
> page table allocations need to be naturally aligned.  The hook will be used
> for upcoming PowerPC support, which has MMU tables that are larger than the
> guest base page size and need to be naturally aligned.
>

Thanks Sean, for these patches. I have addressed your review comments on
v3 of PPC KVM selftests support and ported those on top of this series.
I am still in the process of running the entire series on a real HW
(and some todos/minor changes to be done).

Will soon post v4 of PPC KVM selftests on top of this change series.

> Bury the hook in the physical page allocator to avoid having to plumb a
> rarely used param into the main APIs.
>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

As for this change. LGTM. Feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

