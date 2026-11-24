Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538349;
	b=G5WVe9Y9YFY9cvagBo1/Xeb4l8aABiMcI0F5/es9vEzQ/L0r1ldywK8fLid51v1vM+y/
	 cTFvb6XlvCjM/bUnqFiPBKgZ47z1SHDmYYePQfU0DtnjdsOEkSApmSq+PDgdiy0cxB1Ap
	 SP1WkyWojLIcGY1uM7j9n1zlEpF/8NPIRxF44xoMtALPocB6qbNRA8S4KZ3eqTA89n8FV
	 mBpSk0iAhF0WHA/OlkOhk5y5KTGq1U/7WK78EduImgH1vflgIKwKtb7dT+ulRh8BPHGTS
	 MACoUt7qIshF1jk1o9JnRbnJrZiyFzSTXB1ai3owGhr13hA2lpLfU981LTYSc+o1N1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hX9If82pAfpMeK436h6UILTlGZu6cFz55fiDFmFfVLs=;
	b=zjC8tXD+5lroMWk4zbjMT6r21h8SnGEzVREMEnkjlLUjL95lZS7hx3SzQGHtcIm9hRJX
	 +to+YR7l9EJKtQwW8gwDGaH9PCxDOHnTCPRXs6VTkc5ywt1BXkbz8Y72PtkFWwx+fuOK3
	 zEJVdGbAnQCDLuWaT3kapwqPNh514UIIJU9/kUK94fk2WRDMVnD7JAMl3Yh9V3u/dCreY
	 Vq+UErdr2hRFYc0RiS0EvCiqHndXg/2ldllSmTo/mnjINMn+RlsrFbRtHWDZDTPyDavo1
	 7pdv0eB4fetV+Xio0oc4j+GOQs4+CM1C+loqDbn9y0ygHTBt21ThNahdhMCBB9BlHUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KLPZy0+b;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A6606A323
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 16:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F7A6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KLPZy0+b
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-384c78aa0dbso6590593eec.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 08:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795538348; x=1796143148; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hX9If82pAfpMeK436h6UILTlGZu6cFz55fiDFmFfVLs=;
        b=KLPZy0+bHuhXVJdNnmDF1uSlOai4JtlyiRJ4b9lQ2IEvnH4REB9aTvL9Y+rftk9Aks
         0YjdH0ZYl+IB0kpGd6aTKzXNGrdAI5GUWUdQ39SpQPcc5cMYAVlF/++94c1FDYU3S3/n
         r50M4jT68+1ZbL773ikKcvaWFho0pkuB3gC6nyHtvl+3Bo95qixbONbAhqyTGHCkRjoW
         QVs1A0VT2jEWAUDTSiIwhuSDPQQPhmcg4qp34VhaDmm5oDUvGE09HN22hb8SR3SMpSJp
         ATg6XtB+Dr8xyIopbUN08Penp8ODKir6AMwomjtV18rtz+yolIfPR9W7FGLKNlU8/VYd
         G42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538348; x=1796143148;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hX9If82pAfpMeK436h6UILTlGZu6cFz55fiDFmFfVLs=;
        b=0mk0IWcjSeNPY8Rgstv/QY/I83AOODfdo01cvxV0ZSQiiVV/AqX+0lpFCJVpEgZxhe
         cyAfU7jhv38cwhqb1ojtDA5sAU+qfqG/bGdQx4AQ9fcjrSwyakDvE1QT/6oHxbtXogzS
         JMYVrhwdDqQSKr+JBjHVnywr4eqXsfi5kAwtZkDIvEaEkhQ+eU3SxRI6m4F+8PAw5M5G
         W3MZPRytRVkpAo2v8cKZro54NrYRCZQ9cwvT8606t/4qvQFkN/nWfbSGMDxdBuaCMRne
         i4izR9aF3972GoSV3C594lNcx2SviatJB3btSxl953j5ubhI7yaMSYSHhNBzUfzNM1UW
         qP9w==
X-Forwarded-Encrypted: i=1; AL+hErEkdHqYXqFkiag/jNNYr5xtp2SRQ8C9eWEEoTke4meDf4ZnJ3iqgydE2DpJd+cspwcktb8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ttgj2LzCCUuAJTKeJGgZKSMy3fqfRRYYBxNXqOr4XVunTIg3h
	6KUBy4t7tBK3LK0BKM778yzJ9nwNkEIhnxknOVcL6hFxhhkTjvtBiN73/yIbHEJNEknw2n6a0/Y
	3y0F6jv/x8ui2frL4CQ==
X-Received: from dybkz9.prod.google.com ([2002:a05:7301:1a09:b0:37a:8a0f:3aba])
 (user=zhichuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:d81c:b0:386:b7d2:a279 with SMTP id 5a478bee46e88-386b7d2aba6mr5074472eec.34.1795538348114;
 Tue, 24 Nov 2026 08:39:08 -0800 (PST)
Date: Tue, 24 Nov 2026 16:39:07 +0000
In-Reply-To: <20261124161713.263759-1-zhichuang@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-11-aneesh.kumar@kernel.org> <20261124161713.263759-1-zhichuang@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124163907.476312-1-zhichuang@google.com>
Subject: Re: [PATCH v1 10/10] PCI/TSM: Configure accepted device DMA during
 driver attachment
From: Zhichuang Sun <zhichuang@google.com>
To: aneesh.kumar@kernel.org
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	driver-core@lists.linux.dev, djbw@kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	yilun.xu@linux.intel.com, aik@amd.com, thomas.lendacky@amd.com, 
	ashish.kalra@amd.com, suzuki.poulose@arm.com, steven.price@arm.com, 
	bhelgaas@google.com, jonathan.cameron@huawei.com, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2026 at 04:17:13PM +0000, Zhichuang Sun wrote:
> A short clarification question on this check.

Apologies for the duplicate. Jianxiong and I drafted this question
together and he already sent it; Aneesh and Jason have replied on his
subthread. Please disregard this one.

Thanks,
Zhichuang
