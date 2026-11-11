Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367314;
	b=su/3JSBCHrJ1/HdsGmhCKO8qqPX/FRtm4j1EbRqwCRfWd53vgi/hGgN9iedl4jVOzxFH
	 SBFFmm/Pf+IoZJZmVHeaI+wpHg3jYuymWChdDHGWNXVWe/iL2UQmKtRCD0rTEFnNT3E31
	 0XuBkZwAwuDdTcMq0wueF+0a+X/MslvBoYr0lWsQjnp5QofO+Vkzyyo7A/Th422rW1HEV
	 nOq8qciPqCiKt9HLjZCJpv0Owd9X2WeETMg5Mc7OdcXqxpzRnhDXErFuMNq9q6/IvBe2N
	 3GvKccT8fkaXBu0A+5vUq+8DtmyYwzrqhGJ1pAtbU5W+LbLh9rlDKpAaG3qPM6SdgUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/4/b18xONg/TjeQwy2IjOoUIlFYOpF2rQUSoZ4nHhKY=;
	b=yHi1EKB1OefZ/BsEL3WHKdNyKchRwiu8UkYTuyC9EpXH6QvSdJL0wDTUqD+PKgbFzlce
	 76JXRhMKVo3gUiKpGcthjCAFJmBf7642+001vEeuGg9kOhDyiC1z/I/iGbQWGqc0/sFAt
	 HMnHxXfdtV4tVQOZvzQ4yhs7J4j2NyrCUgyccjFWqK08W9n+PJS15IXeEIPuSa/COyDtw
	 usazl9lGl9DPK3tzqAM3EY1P3sRBSxWQFBWckAkE31BLYiP5QGpjInHIjmWSF4TQTRuOG
	 xqCX2Jw365Or9hdLcjDzLvYC8Jc+2SZhCroCkUIuznQV5jx9SL084ggKDVBl4Jho5lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FrU9LBlm;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239F606A334
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 03:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9239F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FrU9LBlm
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b09a466295so2265845a91.2
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 19:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794367314; x=1794972114; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/4/b18xONg/TjeQwy2IjOoUIlFYOpF2rQUSoZ4nHhKY=;
        b=FrU9LBlm8MLY/US0EdtNgcWsRfNYQxpoBBeb929r2EwX09owXcs15woBd+/VJSBaFo
         LYyVIMzB+LQSB3SLbcLvOKHS9ZTg5v19pSgSFCOlrinjY1nZ0ICxl2EPA50EVkyPo72J
         Dm7blxhkCYsKqdo4MFJffP2qhj6GtdmG+faaS1omx4Szv4ivBbHNVkv8HbKdVKlJB7AS
         B18sEh/Utc7AZ4VBtwkCQc+j7d413/RQsqfJLf8Wl7JOpqUCotnoV3RrMhtxqDgbpWY/
         TqPKyLxuoINUJqPTLlyLtDc882yQFGDc7EftXu1fW/oYZxV4+yulpEni3Vwe2VRgBotr
         Pd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367314; x=1794972114;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/4/b18xONg/TjeQwy2IjOoUIlFYOpF2rQUSoZ4nHhKY=;
        b=kHMrohYBc/sWgAAXUncH7QpMUpmdTcoul4r34DOltlB7vBK7pFerItbqjxc5ruwEIk
         /ZPmaFXfBU4nXq48qIgesdiGQYAUx1rf6qJpWXeB5H/id64DHklEt0tM5Pnb8ECit85h
         6oHQlQ+bP+dd8pRb5uItt03EQ+viqVYINWRiHkjlgTTQkJsutESqM7ojOT1keEd4WwlF
         1yq0RWHtb9OV+Oi9V7JVcqCDSyYQGkj+ECqHRIQaMuAvB32lT99+9SWsg9ulbFKDEPYQ
         PmrWrIChmo+nLZaMC2lJGFfwYavUe13eIk+byWKqB8pvjCxmoDAvfz2/99ncD6aVE2MM
         ZSkA==
X-Gm-Message-State: APuU4Z81aMLP2KMnbChMPB5Ga++2SWVBJ0IyXHLSryqRhHjXat3+EYMu
	Im5Er5WRwWU7TG+F0Z/tZMipK/sGpn0bL55MohIzYX2hUoBRQevDAfI1ar30ozVTrxWm6KYf0/q
	WqRqAhQ==
X-Received: from pjdq9.prod.google.com ([2002:a17:90a:2e09:b0:3ad:32d0:ca0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5110:b0:3a0:7261:d58e
 with SMTP id 98e67ed59e1d1-3b182f65fcemr1096371a91.22.1794367313660; Tue, 10
 Nov 2026 19:21:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Nov 2026 19:21:47 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111032147.166134-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2026.11.11 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is canceled for tomorrow (today for some of you?), as many people are
traveling for KVM Forum.  My apologies for the super late notice, I completely
spaced on sending the official cancelation.
