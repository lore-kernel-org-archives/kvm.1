Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436A422E2E
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177346; cv=none; b=RGs1ER9dBigcJkedd7oO9P3GswDt3s39itZDDjRVUIJ4D7RtjGoD/gih2dXL5zGTGCG5svh2ZiKQ7Y5BZ4eekNHaMDK8DcQCk+5ULDEtfXXJSK42OGeYTE5d/c0LqRg7QeHSsFcbTsoJlhQvYa4yAKxZ7MDFZSLTcV1smjR4Uao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177346; c=relaxed/simple;
	bh=XFyYhXTeik54B4fcoKahFoRLBKApUvIC1kXaWZowbc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqkxnFncP9buQTbOfQHb1obIHhZs1EYbyrSzSg5Z0h6vFHMhUdqyf/pwyzZnlUAiQqROuQpPF0aFtW5K8IulJR7NZVbpL05TrnvF44oftdMwsf4DSAXmD1o1HEzY9aAmJGzpKhsLLx9ejvP8LDEpF/evrY/jLk4p967BRrEBQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NGOc0HBD; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NGOc0HBD"
X-Forwarded-Encrypted: i=1; AHgh+RrqI0/uhFeCxN7QR1SJgbhFFxKSBBEWOlcLCAy66KFd0qgwuz5kavXDZBL+0CDy0LZmFVQ=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785177338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KwsttPieEvyPrTGKzEYr9m1Cr8j+zwTvS+cA4oapoyo=;
	b=NGOc0HBD00C3z9yDp19fvd94KDeEneUC6HUOfA6QPJHglCyFg3P3rqbwyfKI6c27+zJRSW
	7NUk541iOJRfVHz7oJZpCKO3ulIcnsgql2r063seTOlvy5/1Suvghp8/uUNnLMnU2sPX8v
	FTgloQVhMrL/9FN17apQCmMNMv2+5dU=
X-Gm-Message-State: AOJu0YxgKnqkgoKDVkFAGPL8ymImkd4SYg4MrQKqh/TqbYlnfVAKs0Ub
	hizFCEH/e+rSkYBeetX49npt7ubw19c/hH8edHP+nCY8GfRRkuchdi3W+OwJRWHXYqH28ERuHNB
	nIB4Og8yp13rQ3TxHlejwzLIH0+iqJCZQRNQCix+G
X-Received: by 2002:a05:622a:354:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-529a5f15b56mr40755811cf.8.1785177335476; Mon, 27 Jul 2026
 11:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724104819.1296803-1-sascha.bischoff@arm.com> <20260724104819.1296803-21-sascha.bischoff@arm.com>
In-Reply-To: <20260724104819.1296803-21-sascha.bischoff@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 27 Jul 2026 19:34:58 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxtSGHO__O6V+Km+3f5ASJepA=5cVHs8BdjJoLbRwbLpg@mail.gmail.com>
X-Gm-Features: AUfX_mxf8D38n9yuNlqRG7bxJInR1aSDZxlbsMy4SmN-tvZfAPBS-ChXFUbS8uQ
Message-ID: <CA+EHjTxtSGHO__O6V+Km+3f5ASJepA=5cVHs8BdjJoLbRwbLpg@mail.gmail.com>
Subject: Re: [PATCH v4 20/48] KVM: arm64: gic-v5: Add GICv5 IRS IODEV and MMIO emulation
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, Joey Gouly <Joey.Gouly@arm.com>, 
	Suzuki Poulose <Suzuki.Poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	Timothy Hayes <Timothy.Hayes@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Sascha,

On Fri, 24 Jul 2026 at 11:54, Sascha Bischoff <Sascha.Bischoff@arm.com> wrote:
...

> +       case GICV5_IRS_IDR1:
> +               value = FIELD_PREP(GICV5_IRS_IDR1_PE_CNT,
> +                                  atomic_read(&vcpu->kvm->online_vcpus));
> +               /*
> +                * IRS_IDR1 encodes IAFFID_BITS as N - 1.
> +                */
> +               vpe_id_bits = vgic_v5_vmte_vpe_id_bits(vcpu);
> +               value |= FIELD_PREP(GICV5_IRS_IDR1_IAFFID_BITS, vpe_id_bits - 1);

I think the advertised IAFFID width might not cover the IAFFIDs KVM hands out.

vgic_v5_vmte_vpe_id_bits() sizes the VPE ID space from the vCPU count,
but the IAFFID a guest reads from ICC_IAFFIDR_EL1 is vcpu_id, which
userspace picks. Two vCPUs created with IDs 0 and 300 give an
IAFFID_BITS of one implemented bit, with the second vCPU reporting
300. I could not find anything in the spec requiring the reported
IAFFID to fit the advertised width, but to be sufficient to identify
every PE in the system if my read is correct.

Cheers,
/fuad
