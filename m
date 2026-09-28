Received: from mta0.migadu.com (out-216.mta0.migadu.com [91.218.175.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697C4E3EF6
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617647; cv=none; b=i7prFF86zJ+Ekhje7Fen216kcEcZbmRbRG6Aq/OPiRCnt6vnYZ2gf1GMjomU2b4aLi37UEpqUsdg3i7svpMgqbhv5o3dLOmIO5Th4f+XKaUDbrRQKTEZamog6zWWEQsQ2NisDLFpzDLPVerY5G53frBCDfNqFk4x18743qoe2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617647; c=relaxed/simple;
	bh=XyuHMcU9BbS4rZO3qSAgRdBv7BTX7Z9PJ3I+SxV2FeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTrZHvYnroNbg/JP3WYvp9XLfLoJGPSRXVVjgQ9zMZe+QrCtuGdpuLyo3WfrOceoHOK2TS8bMqkdw8BLJqVlhiQIUevpAAcQUUkl7Kt3Aefit0jwzmqVqHVAocFveEA0tyXZpFnOuVN4DFGN4bGaVbIIv5VmPXDv59fjahdpjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rG+cYlCp; arc=none smtp.client-ip=91.218.175.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rG+cYlCp"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XyuHMcU9BbS4rZO3qSAgRdBv7BTX7Z9PJ3I+SxV2FeE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790617639; v=1; x=1791222439;
 b=rG+cYlCpWA7YUysgTp+nJZS8DB0k3hg004QgeE6o77dfXykYd0WV2i9ocLruRHgghTEGY7Tn
 baTMLQXUYdTh2X2O1hxTJ7p8/gwUoB2Tlcdc4/xuS+zAXSv/9PQDTgKNCtCZgnyZZdMyztzkXuM
 i/2v3ZqOPBdsQR407E0kjFRA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dc16216e8299a601;
	Mon, 28 Sep 2026 17:47:19 +0000
X-Mizu-Trace-ID: dc16216e8299a601
X-Migadu-Flow: FLOW_OUT
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ab0140ecb2so1200a12.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:47:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByIvN3GRg+ko24e12cDiFoaOfIDjPkncnm2YC2kN6maVRAeVjsXbPFmr9LzQa1eXx+9ypc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7PqFRZdVeFgBbDVwRfuf5cUD1AaeJiI03oIMV1n6eYYJmaHHc
	6Jw1m3/tvdfj7UqZJjRyZYn47aLEQKx+kHuaQI+1grRLvYMkadwWm3aaiKEGwP/4uyUp5B+t8ss
	QCrrHcS6DuOwb8Qd6ixzzC3VUsTmRRK/XmU6s0GP3
X-Received: by 2002:aa7:ca57:0:b0:6a6:967c:3186 with SMTP id
 4fb4d7f45d1cf-6ab01ed939fmr94944a12.2.1790617638152; Mon, 28 Sep 2026
 10:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928152507.2116110-1-fuad.tabba@linux.dev>
 <20260928152507.2116110-5-fuad.tabba@linux.dev> <arqaNHGzVfMpVha5@kernel.org>
In-Reply-To: <arqaNHGzVfMpVha5@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 28 Sep 2026 18:46:40 +0100
X-Gmail-Original-Message-ID: <CA+EHjTz=sKCZpQzLkMaks0o5hR-R=ACKVinPgwzAiyVUubirxA@mail.gmail.com>
X-Gm-Features: AclHuK-Tq_Aet2hB71IGOYbMLUlrt7UHvVGW8T4ukejDyUoOFxO6nR4iiKf3Ohs
Message-ID: <CA+EHjTz=sKCZpQzLkMaks0o5hR-R=ACKVinPgwzAiyVUubirxA@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] KVM: arm64: nv: Return a failed stage-2
 descriptor read as a fault
To: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jing Zhang <jingzhangos@google.com>, Karl Mehltretter <kmehltretter@gmail.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Oliver,

On Mon, 28 Sep 2026 17:47:48 +0100, Oliver Upton <oupton@kernel.org> wrote:
[...]
> Hmm. Rather than fixing these things individually, I'd prefer aligning return
> codes between the S1 and S2 walks. I agree with the approach; negative
> return codes should be reserved for host-visible failure reasons whereas
> everything guest visible gets communicated through s1_walk_result /
> kvm_s2_trans.

Makes sense. I'll bring the S1 walk in line with that in the respin,
with the Data Abort change on top.

Cheers,
/fuad
