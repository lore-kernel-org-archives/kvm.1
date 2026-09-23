Received: from mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079934A0133
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161697; cv=none; b=BrMJl9Hyh5UNI7Lrk57hboEFmUSp0fZ10HvNFoV4BgFasD3MTxkIaMTYVPJ0rPB+EHT+ksOF8NQCi5CA8rBUyNBoHjMWwLavL8/6eiCN+7MJubL71nv8fLt3aqAnF8ve0paMDVXFa9NHTvv9+qADrY1cTl4Ww7sAy5mT3k9yPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161697; c=relaxed/simple;
	bh=IOAKMmCBlI6Y5ADecDu+BXYPFKPVLUehlx/wlSNc7CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVlip6t4KMXvnzOiNX3nSc8xTMjd8rFn0MGWBF+cECRtz7OJ0bgXGworvIw8NffQzrQrQmRN9gHSgxh0qrvMUelR9qcCn7EqqB2vq45u0CBDXTsRFmq4hgBQHdAKHAcLORsh5W/lFJTFyow3dNa0W4OyMvE4ZRWHKtGcgIJe2w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K1f5KnAK; arc=none smtp.client-ip=91.218.175.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K1f5KnAK"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IOAKMmCBlI6Y5ADecDu+BXYPFKPVLUehlx/wlSNc7CU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790161693; v=1; x=1790766493;
 b=K1f5KnAK3X79y758eL3FPSJ/DANtoCt/5fZbbIs46sjxtFnbxpJg5c/iOJeC9eMyRifWDCPP
 F6HMfi87SOY71tTVfJuKEJSidQwPGHr5pK1Ahs96T+6YAWS8njVuPiSbp5cCa7a4TWMO5StEGHt
 DFXaXhdzPS4yIBM0luvWvjxU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d230ef521c69ae94;
	Wed, 23 Sep 2026 11:08:13 +0000
X-Mizu-Trace-ID: d230ef521c69ae94
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso4544e87.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 04:08:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx3yODkp8o6+dzZ8xI5RdY6Y0SiBs9IKeQQG18NMixCgH3MgqrVreZeHA3Qj84YpQwFZBM=@vger.kernel.org
X-Gm-Message-State: AFuF++lpTXO9aWVPoAEz2aIInW4Ln2wBIJpizs3X/iH88c7nGhV2BWbN
	5r3nfBmIUqEoJMZsml2ZHDWzWuMd65agoYwQas5b8NDNMH+hTgY2pEgGTVynFoJ2pj8sw49okuw
	G4HszTtXQROtadolzoRW00k/vxmFtjONha2f/X12J
X-Received: by 2002:a05:6512:648a:b0:5b6:4ad:d6ba with SMTP id
 2adb3069b0e04-5b8d91673a2mr102638e87.15.1790161689001; Wed, 23 Sep 2026
 04:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-kvm-arm-prefault-v3-0-787bd3bc7e3f@kernel.org> <20260922-kvm-arm-prefault-v3-9-787bd3bc7e3f@kernel.org>
In-Reply-To: <20260922-kvm-arm-prefault-v3-9-787bd3bc7e3f@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 23 Sep 2026 12:07:32 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzY6KFekqaUX4RLRyFmSkFhOeWDZE4LjBF6owdLM8oHhw@mail.gmail.com>
X-Gm-Features: AcwNN1USJQu0cBxPqG4Fa3XJmPPBE73PzJ6UtD9si6PNBcHUySSR3TM9mD5mIUk
Message-ID: <CA+EHjTzY6KFekqaUX4RLRyFmSkFhOeWDZE4LjBF6owdLM8oHhw@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] KVM: arm64: Pass walk flags to kvm_pgtable_get_leaf()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jack Thomson <jackabt@amazon.com>, Jack Thomson <jackabt.amazon@gmail.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Vincent Donnefort <vdonnefort@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Leo Soares Passos <Leo.Bras@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 15:19, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> From: Jack Thomson <jackabt@amazon.com>
>
> Allow callers of kvm_pgtable_get_leaf() to specify the page-table walk
> flags, in preparation for performing walks under the MMU read lock.
>
> Reading a stage-2 leaf while only holding the read lock requires
> KVM_PGTABLE_WALK_SHARED: parallel faults (which also only hold the read
> lock) can unlink table pages and free them via RCU, so the walker must
> be inside an RCU read-side critical section, which the shared walk flag
> provides via kvm_pgtable_walk_begin().
>
> All existing callers either hold the write lock, walk with interrupts
> disabled, or run at hyp where shared walks are rejected; they keep the
> current behaviour by passing no flags.
>
> No functional change intended.
>
> Signed-off-by: Jack Thomson <jackabt@amazon.com>
> [ljs: fixup new kvm_pgtable_get_leaf() invocation]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
