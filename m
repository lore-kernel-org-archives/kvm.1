Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979386;
	b=pGTHqY9gdzRxo3Zlr0gKxHq/OR8BrV2LMPAJGzoOn/SMfqVdVy8ZlHs2vD/EIs9/BI71
	 u7CFt5VjUSUN49XkQSr6PD4iqggXS/rIJ5njMlSGmRRNO4+e6ihY7rKCsePkrk2/rSVct
	 Lr6oRYCaur/5KrMx5z3mQ77okKvi+bzFUWXvi0aFE8HQFIRm4Lw0vMUk//78KzEDnq3A8
	 in16HWtmVB/YdMKTb9GKEiI42i2wOVjCfKnQcmLVZ+UzwcQ5Z1ZdDHg1f/aTVaM9VIDrP
	 PVNwRUrX8aCmqowqJ1eXm/7y3PgoIs3le1cYvmFd10oT2dZUdtGAL7iN0Bow4+V9Sdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979386;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=ofV2qVpqrfBMyd1/zLMm6/WPtcgEV4myUPpyNdz12kw=;
	b=ZiSgvI174AfQr/OpIBnRYGtZUrbACKEguUiJGm3nV+3a81Aa6iFjyANJBngp/Hx6iwGE
	 sRz5XuiXGht4T6bdn8YStAUTEjMZHLOtXRYEcR5VtfNbhPAwM3dzeVflDgsJXx/g28nZl
	 nUfYHfUy13rZmnwTXjASPG+Zeq7T7bdSslaydQB6TKZKmIdCdjH3LaXTFfgUPbbRuKvOv
	 yLv2NdNRybH+G5/lanIl1x1BHIUq8qkFJ9Epq/8fj46OwDCJqWX4Gg0oL6GJdJQ/Tr5XQ
	 9ztYJgr5NL205Ve6LMBBXL6vVYIHaSc3FVCJXsdemKFejI4NXzRYFxa0BcUlKbjJkzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i6gT6Pc0;
	arc=none smtp.remote-ip=91.218.175.52
Received: from mta0.migadu.com (out-52.mta0.migadu.com [91.218.175.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E63606A32C
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 15:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E63606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i6gT6Pc0
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ofV2qVpqrfBMyd1/zLMm6/WPtcgEV4myUPpyNdz12kw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793979383; v=1; x=1794584183;
 b=i6gT6Pc06lO9N7kzo79T+n6ldfGS78/XtUP39dlTC3iBDTQu1/zNcfzplnzFaPAq66iNScW8
 D6MWZTcqjtpK8LiFh83phERGwUUYyC00d0+yqpiNyvnnc2ucCl8mIRVGY9VUdN5VfN6wVA9D/sn
 bvR/h8sjoTIfufxnETg2To4c=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ba9fc4a49a10d827;
	Fri, 06 Nov 2026 15:36:23 +0000
X-Mizu-Trace-ID: ba9fc4a49a10d827
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bff701efa5so791e87.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 07:36:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzV7dJYARj9GDdCtqf0bFjqD07d0tYh4sn5dNJiL5nPUR92He7haNpEc4W+NNeKQt51WO8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/01Z7pG4DlmR3Ks9R/DvOBvhziG1DIzq/c6vGP0EHzwObKwzye
	LwI6PbvILqk2XWp1StimJKwMM7zO2KHFHTuirW1zvkCIehHwHerWOnINwOIlxISnfqOVl/uf53T
	BRvlwG2f9XiH+c0XVwSjgCEElZYHu4qbK1oO59GJN
X-Received: by 2002:a05:6512:1056:b0:5bf:f81a:f24e with SMTP id
 2adb3069b0e04-5c00a413bc5mr6933e87.10.1793979382196; Fri, 06 Nov 2026
 07:36:22 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104084842.132944-1-fuad.tabba@linux.dev> <20261104084842.132944-7-fuad.tabba@linux.dev>
 <au3pNFOMeIx2X4Dp@e143914.arm.com>
In-Reply-To: <au3pNFOMeIx2X4Dp@e143914.arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 6 Nov 2026 15:35:45 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwMv8NZvTy2cVtGRLoHxABZiv7yYUdRBHE69ieFUxoRXQ@mail.gmail.com>
X-Gm-Features: AclHuK_ZZQXxaDxpRQHq7T9rnG0s3OxixfWJ81iGmmqdPNJp-0OMdSXL2rZvnds
Message-ID: <CA+EHjTwMv8NZvTy2cVtGRLoHxABZiv7yYUdRBHE69ieFUxoRXQ@mail.gmail.com>
Subject: Re: [PATCH 06/16] KVM: arm64: selftests: Add protected-VM library helpers
To: Joey Gouly <joey.gouly@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Quentin Perret <qperret@google.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 at 14:50, Joey Gouly <joey.gouly@arm.com> wrote:
[...]
> One minor thing below, that could be addressed or not.
>
> Reviewed-by: Joey Gouly <joey.gouly@arm.com>

Thanks!

[...]

> > +void pkvm_run_loop(struct kvm_vcpu *vcpu, void (*on_sync)(struct kvm_vcpu *vcpu, struct ucall *uc));
> > +size_t pkvm_host_locked_vm(void);
> > +
>
> Could add a comment here:
>
> // Called from the guest
>
> As you have those 'Call' / contract comments above.

Ack.

Cheers,
/fuad
