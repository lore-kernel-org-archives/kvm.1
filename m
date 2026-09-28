Received: from mta1.migadu.com (out-101.mta1.migadu.com [95.215.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8482D8DD0
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612137; cv=none; b=Q2hHazcIyzr8pnTONE5wWyELfaK9IVfAFf+7bJHrVd0UnNbq3RMdeHeOXywDPrr/gt4BGBIKBxYIpcpeW+nFuzYH4dvNl0MULXjqMkzcJfD/bQ2wgGxUZ1/EmKGahKtzbjWcRnxT47RG94e5jfF4YrPKf/0+z4Dalz7KzpUipcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612137; c=relaxed/simple;
	bh=c06SVugHWJJNDeT83SdkPtIHJEt16Y1SGd4fojskXEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eg5NQTkYQA2EylzD3G2Cj/oNqfZ+Ebgfm8W5+rMD7QoMVDJML05R+7QdA3kwSP/mSyzwSrJl01n5jqKDJyruB02d44cFuKBM+sRRFjEN3S2p0PwFzc/GwwEAmrOnOeopeiY+MqfKrw7vimHD5GXCFB4oDbDPPV5rKGgemVX34So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hXVwb4fP; arc=none smtp.client-ip=95.215.58.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hXVwb4fP"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=c06SVugHWJJNDeT83SdkPtIHJEt16Y1SGd4fojskXEI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790612130; v=1; x=1791216930;
 b=hXVwb4fP6XdcWRhSE1I3JsxJd/RjcntURvpXXNKt9dsZyWADlSV/mYCuVQs6by0MWU6K17ev
 dla2e7r9aR/3VybfWF+W7aoFNf6/fb7tqUM02/AuNcN+qO02yq/4GLhHNHj91tvaJJdE/jsSo5n
 9Yz7WxXrdPDLbXSCD4WulRz8=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4ce84824bd2d8e50;
	Mon, 28 Sep 2026 16:15:29 +0000
X-Mizu-Trace-ID: 4ce84824bd2d8e50
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b8ea0ca5baso11811e87.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 09:15:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByYilHVZcM4MxHwCcqDTzWQGltCs0fg/0SYIUn+HQNZPpNie4Xg4K31iwcqZw1U2tzXNxE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCoOnNb3uGA0GBWIl+1tjfzYDB8dBYQkhEt8cfeYOPQB8T2S0m
	tXOW/Emlz4w2I0Ov3XH3CnBHKcICgImYd7kAOmmM3RK8KvUOB2PQrZBKaReB6uDYzuz1rmKFEGI
	AYua7SBfTR0KlX1cS1z59+0A+LaswHPK3wljz1w8M
X-Received: by 2002:a05:6512:220c:b0:5ae:b726:5f1f with SMTP id
 2adb3069b0e04-5b8ef277c63mr220456e87.8.1790612128596; Mon, 28 Sep 2026
 09:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928152507.2116110-1-fuad.tabba@linux.dev>
 <20260928152507.2116110-2-fuad.tabba@linux.dev> <arqNu0rSxIz4-Mue@kernel.org>
In-Reply-To: <arqNu0rSxIz4-Mue@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 28 Sep 2026 17:14:52 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwiqsvxXV7fm8emQHWW7qYrQ79J4V+5Erot5Df2=YaLXQ@mail.gmail.com>
X-Gm-Features: AclHuK89NS8J3Mx20bby02ytOoblOsUcBV9_SKsrfeTNez43AkDgos1HN6Dw7f0
Message-ID: <CA+EHjTwiqsvxXV7fm8emQHWW7qYrQ79J4V+5Erot5Df2=YaLXQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] KVM: arm64: Don't WARN on SMCCC filter reserved
 range allocation failure
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

On Mon, 28 Sep 2026 16:54:35 +0100, Oliver Upton <oupton@kernel.org> wrote:
[...]
> Eh, the warn is still useful. You could potentially add a check for
> -ENOMEM but any other return value is a sign of something wrong in
> KVM.

Ack, I'll keep the WARN and exempt -ENOMEM in v2 (or the new series
this becomes part of).

Cheers,
/fuad
