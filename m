Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7536F900
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615835; cv=none; b=WDsirIhu5IMJ5CJmBgSaM1Xf3LiUNE7uev80jIB8cC4gwoJgt+dXyFI7Y+wW6zZtJPSKkBNwbh2cuzoUg9aAslBfnyafM00hAnSeKgUKQwtHxnMZszXHjdcVFpinTxUHrg+bfcj1B3qigcbrJ67uk3MqHIM9fSI+e8IFjgS/dEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615835; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMQQUt0rfXplOghjzarZF0lJKelbpamx/9H4LsSi1cjfNj9Nuu+sfY5oF2dJziWqH0iXVoBrQJrLCKdANGyI3ZGDBUgMzjXRADjaafK7mtVfj28Wnsh2ShdMzt2dgNmCnRsEz3jYHC9Drw+uBulB29ie/asU102LNcpA5NEi8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nv09QCt2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3Y91WYU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nv09QCt2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3Y91WYU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778615833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=Nv09QCt266RNIuVxhRpeer6dwNWVcr7QMpdVQRKdONv2MG9PAk/TAOjc/KCKWReuRBwVTa
	7SLT1bVbaghxSJbWKheB4a4LMrNVASMZy9JelRQSdiZxV/bzQdLwu1tSWbmI7Onw6V+Ey3
	ckthsDpl2zgVF3JZqCNo+YPeVQjjkaI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-GmiG0BbTPpSo9Wc-JQwXhg-1; Tue, 12 May 2026 15:57:11 -0400
X-MC-Unique: GmiG0BbTPpSo9Wc-JQwXhg-1
X-Mimecast-MFC-AGG-ID: GmiG0BbTPpSo9Wc-JQwXhg_1778615830
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a52d5e572so3864660f8f.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778615830; x=1779220630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=O3Y91WYUvE4VCc9i5DdsRzdnu87HdwWRTM2Whm7fVbsg68LI8HSWPBsrOOeWxYspil
         xmX7nAPK0lPgjQC1EFgZomGLKYUy5HyXNgl8qNNk3mmtAIRqfBZDmi0LfERY9YLrX2Vd
         1eF39naqPEac55zhc5eo+PTdsx4z45WY+BfBIh5ZGPgiGDvaWivC0ndI+uEyQkD+W2JN
         P7cJWl6WAI7lGEPiIayFY9cXV6g2NV/xhX5CA3m/M7jMI2j12e/H3fV8tQqabvekbCBg
         ERS5RUnM9I0iGyB+/2OnUl1orsO3R7bMI0jGAXcf5F5jr4KiY64tFJWp5mLceZ9HC6bI
         wjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778615830; x=1779220630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=T8h/Oe8bBduihq+PSgtV8BskHofOBhopXFiPH3rSFJsNmIMdnm1JJgoyAhxfJvciGe
         e1Qmojq1bLWZwiiBiie/M13WMAYQ6jBnwKKoywKI5uRza9wqGDDxOhcLoqVFOt0YH1Xn
         ht5nvWMdIjqbBpjTdOB5GriEfNHaMc5JAhY2bT9IyHmyIAtAD3S3IXKN4JaltamJ+IGU
         B/pblDcrc9GjVox/VJEQGPA5YaH3+/UY/STefri3fKfOVml1Sx4rbSjgaSRyvPGnhyyE
         O18jSVFgtnkK+GMXPXeVzpt5daFJV//ZtWLnpNA9WpUAZUtHbRSjc8eow3eqCmPYjvxq
         cNeA==
X-Forwarded-Encrypted: i=1; AFNElJ8idNRxMCKO6fg0FzOL8zpGMB3U+LwZ2AdXt4UZnw4PfeB2X6vIwCCHueXLnPyfiSnVxV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWILXc+kMf7lxOhdeqkqGQPpbyGyKv01/+7ZA3n0H7DCT3Srq7
	XFtUO4VyYWXs5BPa5Z0S9gXIi2gywy/sT+7XOAiJPjQ3Y4PXeoNIi2NYaPW8JM4NlU3P0kLnko3
	Zt0e0Xj1Xthe3jGYeUS6rogm7uw0bgIBi/B7O2SDDc3XJBCOEog3CCg==
X-Gm-Gg: Acq92OGCUQ0YwfirHID7VFmUuWlSeneMtweeqZRHLdWyFcQH0eubUd4SN9CVy4L52SB
	9Zp9bUS2+SFEQCKutQsBVWYu388cp8H7D0ZMoFK3dN1MaAIOo7rwzG8Pgy/fxEQrUpp8MqtrlpM
	GvE2MTSpzPU6w8r8VKCbJ4827yD+ValUCtjd52ZXi0G8mrGENCyMQmpohhsUuehWlbBjWS9EKm4
	FodRfAs5pBWRF7AxXIWWsPSlNlzN8wBzcuIShPue40/RYC2TpSi0onQ+3fWwhMYBWqdLmI8c7y2
	eeOAkCzIPW8H5FVaoQH+p06VyFlibyf+NTn8/9zP1As7Du09zQLtBLsyoJIdWFSisjJdirlvHXv
	Z1JgEZ0MF288ZXMCl53eKk9rsxyIikc30oKqVYG0vTG5A4uiGGZkL45XE6gTNL+44jLadjvpFQf
	200OclF6obx6ipQtHkkZpx3+qz+E7X
X-Received: by 2002:a05:6000:2388:b0:43d:1cec:4767 with SMTP id ffacd0b85a97d-45c599e7c22mr293759f8f.36.1778615830282;
        Tue, 12 May 2026 12:57:10 -0700 (PDT)
X-Received: by 2002:a05:6000:2388:b0:43d:1cec:4767 with SMTP id ffacd0b85a97d-45c599e7c22mr293714f8f.36.1778615829787;
        Tue, 12 May 2026 12:57:09 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491cab9c2sm36859507f8f.31.2026.05.12.12.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:57:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix Xen hypercall tracepoint argument assignment
Date: Tue, 12 May 2026 21:57:03 +0200
Message-ID: <20260512195703.3017231-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512015313.1685784-1-maqianga@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued, thanks.

Paolo

