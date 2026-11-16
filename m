Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868724;
	b=pw0+RBaHF9yXPMyF5wGk7FZoy06UDrmcRiHmxiNANcIqlJMYtN8VabZUWYX/8U8E/Fls
	 LMyXlGie2+/2lXviaxwtPljFX30tctosPQpaTxtb3UvVqEJoxBVK82PU6sNwBADqA0kuV
	 Yd7SkLif60yeib8YUX8r3YXCU1Ca3fi/xFO+XfwPcHTg1t1x7i0P5T03Hc3k5DplsBuL2
	 xBoqlMfvSgdxRQr9JLW2e6wDQD+5o8TBFDzQirw38tYnbxkM+jrVD2Y/Mc40Ww/WYTfaO
	 WoDt34QW7l4Q61v4WzrqpWh0Qqg+1JzyLAUCd0DpQzDhmaECgO8SqKTh4+efwm+Ps7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=PXYG1uTYbw/0oX/X9RQZfRtyTf87d2Ai8vb7xAgZiNc=;
	b=Ew2j9SsCoxN6wX111OQVlWc3gsYrsYjOTwKiKT7jAaDH8ZfEwVqDIR6PY26ZXY/sYuU3
	 RIHnjatuC1HBFmMAd5YeCBOLQ+A8z8QmJdKMoqU0J15tITM1rjSHjlXJML4TqWRlr7g2/
	 P/Shb8/NUV4cENBjBDCQQDrW4UNfSIe73k6oBATFoiUypkZ0VpwGICWSCqw9Pq8zlcH71
	 m8seZIOo/yvHN33wpysXeqqCso8EQCqxZDzfC5DupmwOLuku+818RY0ETszDqmXhQXQXJ
	 VCQO0A5f+VgYxw3TrqKM5VXFa89vJBeMxgyWg5wJWV2GPP13muwecewZiDc1PWVXbiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eCfaxdJr;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B19606A887
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 22:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3B19606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eCfaxdJr
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e95f8543c9so56714915ad.3
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 14:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794868723; x=1795473523; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXYG1uTYbw/0oX/X9RQZfRtyTf87d2Ai8vb7xAgZiNc=;
        b=eCfaxdJrSL3xkCohe4ifwJza4FxjckUsuO0Nn3RiUUgWtAMchQUYCZXdh32mPKZ1gu
         mgHmtuXBpRUpDCNhTE2upAHYZ/Xg/4QI86bb0L6LmeedZXf60WGbkwTzcKCvEx36XdhE
         DGq2C6kTXMpmz1L+B+fnvwbSMGJZotTyTDiZKSdL/cbLM/WXxXBIuoT690nskkdXUvmA
         RGlvhRImIp+1kWU++3Rcl/4jS4RFsK0fOvmroQitps/2viLOKCPXBSMGKwvbqL7VVJkq
         duQNVoBetO2bSXmLcidC//uTRFnEXvVXH7U4WMwcvM0BJXIg73NBdS/wn2JM2Kpxh5Rl
         WLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868723; x=1795473523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXYG1uTYbw/0oX/X9RQZfRtyTf87d2Ai8vb7xAgZiNc=;
        b=s8+kVPdHJxsVKkT3KJbExn+TuyRGZqzqJLmagFERq0VWW+/zUMT+u3lffXroqBevJ7
         Gi/7yRGfsuXYZYESYgAo9H3aDBIYSskI4K6IE1GQyh8FswOf0SdJfA3pNrg13EJeK6sQ
         CQssd29YNMo2iqfvc96B9GFASBIw4WtMpu9Xow+UdY6X59Eug+Zm3rWO3PzU9I6whHZI
         3HsLaJoZOrMvYxG6+mTyXPBbJ0JAI/kgYYYnJDp9O3N0xYiBrcoVLtiyxb6sdHrjLzZg
         zmCdmAZbAcOmH4FTTlSd7SvnpGKbcrUih6MyX7BaNPlTZQBCOB+4BDz9foJg5N6G4urv
         Qbrw==
X-Forwarded-Encrypted: i=1; AL+hErGydNJ+KOnuIm5TyuwdqC+LlDeIQ9E9/+H+iQb3XxMxmu6HmwztBEHu55bEdEnSoGgmalc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cI6DyJabr4OLFixZQKU6EufV/Zbn6iU6K1zmRMRBD129Y7UZ4
	iXbr3Pn248f2ZvJcrGQbsyMxMnvrEyp473Bf0i9/zvZa50JuA4Oq5udSnhu4oW3KXc9nOJhr9g+
	QqljoFQ==
X-Received: from plbnb14.prod.google.com ([2002:a17:903:15ce:b0:2e9:5442:b91a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef0c:b0:2e9:6972:54d2
 with SMTP id d9443c01a7336-2ee0de12039mr120569555ad.12.1794868722936; Mon, 16
 Nov 2026 14:38:42 -0800 (PST)
Date: Mon, 16 Nov 2026 14:38:42 -0800
In-Reply-To: <20261116223033.3866283-1-ma.mandourr@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116223033.3866283-1-ma.mandourr@gmail.com>
Message-ID: <avuF8vW3g_o1t5DM@seanjc-mac.roam.internal>
Subject: Re: [PATCH v3 0/3] KVM: nVMX: Don't clobber VM-Entry instruction
 length on soft INTn exits
From: Sean Christopherson <seanjc@google.com>
To: Mahmoud Abumandour <ma.mandourr@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 16, 2026, Mahmoud Abumandour wrote:
> KVM writes the length of a soft INTn that L2 was vectoring at the time of a
> nested VM-Exit into vmcs12's VM-Entry instruction length instead of the VM-Exit
> instruction length.
> 
> Patch 1 is there because Sashiko pointed out that prepare_vmcs12() overwrites
> the VM-exit instruction length that vmcs12_save_pending_event() saves for soft
> events.
> 
> v3:
>  - Rebased onto kvm-x86/next.

v2 still applies cleanly, there's no need to rebase.  I realize it's been several
weeks since you posted v2, but the reality is that everyone and their mother is
using AI to send patches right now, and so anything that isn't affecting real world
use cases is very low priority.  Sorry.

TL;DR: please be patient.
