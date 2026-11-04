Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813091;
	b=rTpsydCYDqEsBLsPhHJXfKBjy6eB+w8FE1IwhR/TfRPpU+/2XZk9AAna0CEAPB6lV9s7
	 SiKTp8FJNZDE/hS6L3VIT6cxEQQ3QOdm9Z22ovM4f8ebsrsu8FqPJSge4BdFnR4r1i9wW
	 NfBGB+bJHbEnzyXHcfu1u+ZSw2iz2JiYFrM+b0RuGNJ3wjxs432FfujM1Pa906D8jCF/w
	 w9nl0b9n98qnpsHeVTmbAXIhrxXiuZiwYE7XRApeTQ/IAe+eWgwsInjbPu91Xr/2tgc8L
	 vQyypZzKuDAibcATTRz+MkoI4jyJ2Mqk2QC2rT/wpSxrr/1fX+EuzStGhCR1YKQ+L2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9GhfeK0P2s40S/hh46Y07C92GF3aVYPq8kDhBl4KyJw=;
	b=kAWG/cZBikSTLJ0EfMT1Miv8xCzi3d0wA/TWkZGdXD1jACFFdwMtBtgnqFILUPpGTnu2
	 fq8kcn0/e0IrhPK75FzEv97+4VFDH8vg6B//LTJfcKYGgt+OCt+moZdNg4KPynIvffmDg
	 NoFMgmZtnrMGINMP7EFWExSwbopJ56U/GSbAv3aBe5TZgFm/7aTMTnebe/b/h2I1LHNxP
	 qY20LWMjZqhMtFLlw1Sm2KL+k2mIzxS9ctoDXi616h08P9ZyzZdy80zk/3QE9VKcm5Fsj
	 u95eJeIA8Peo1HmKNue33FQueH/KuGUfbXxZZvKpLN1EMcq2HzWNQT1c8c0y1Lg9JFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PEuUv/An";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6318606D811
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 17:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6318606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PEuUv/An
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so263945f8f.2
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 09:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793813089; x=1794417889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9GhfeK0P2s40S/hh46Y07C92GF3aVYPq8kDhBl4KyJw=;
        b=PEuUv/AnzFxAU8Lz6CU2kYUqdC0vxnR9PRHZBqtOiE3NWl7h0/NmMOpy/x2Rb+3y2+
         TF+kpn2/fq2tVD1krsyNQDaBTypuYI9131R5uhmZOLawQrEdBn9oGBWIB0kTw5OnY/4c
         WfYPKegdto4Mrd3RzlupmSWo54LCweuN7uvvAlyWZbIPxIcknQI14qWR5zJU1MtuZXKW
         b0AaBirsXBIAcJtexxPJyFdXzkPANHffqAiMqeUzc8UVddUj5ubiQESzGHOWjrrmYXMa
         nbfwapSlKE1Cfo2VxHy5VnLHLwNTD2szzgPZwz13plng60hXYKv/Diyjf5TiEwIzZpeH
         5NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813089; x=1794417889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9GhfeK0P2s40S/hh46Y07C92GF3aVYPq8kDhBl4KyJw=;
        b=yrehcHlMHqOHw7k/tFFYJzEdnr4a5mDGAZLlvfSc0o3ly9n/2kqznxO9nAVYLwr93T
         Z12YKb30jHP7PC7hgi6Vw7Ui9pVoRsJnSqJQKXHX/WQFXU4J+4FVGxCGX1O0WCP325uF
         s52K29YpUkn+7XNeErOetVH/DSHJUWHqT0wRbVZ5Qgv3822Fh3QeZCc+Uujovod6vC1c
         OgItr8KFjeBeQSQ5BpXCzen924FhdOOVOdbNEip89i4zoNruLIODKbUdR4KrhztTDjdQ
         oYrycSGj/3EGBndhYddDKsgRlskmrrm36ch+Mcbua85Inl0Z/y7rQGE9uQLDhWFwqSLB
         w88Q==
X-Forwarded-Encrypted: i=1; AKwUvBxs1Roc2p0JNXUBXb1YOBsSQyy/xSZ96iCiwxKvWfVuxh0ffF+ZU9yu6SN9t0fi1tKCoJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3nwfzXmEe/QehV4GpdIlbsNRy+kXJVPrZKO8uHgBhSYtbVTKQ
	sOGpKFL5wILd0eEceL+5vItJv+mk6VJzjCUEBVELUnSieQkJlEDmYpCO
X-Gm-Gg: AYBFou0+tGXB3bmldWUSzqJVUOBhiK7QjH11ngmFj9VQOOq5HVnIwo8cp0YpdsHzUcA
	wV6I84cNsyF9o0nW3AQUkg5gZc0T/OYvofBJHn+ChwjRqb4+wLZGqupRXKM2/oVDJm7QOycf2nN
	n/+9QG958Dt5HwgTmXPOpNUanAMFmFpRzfZbipAilxD1seRbPQHvHX1qoPtDGZuBK2F+8Jn1P1B
	9XJawJ+93yGIWuAy5iZtQaVhKMayxklkRHUKe4ILDdZlh/pjFKRst9r8RAwes2ZbZPnTM3/kYNc
	FZYU4HeTqnkorqvD5Cr41srKR0KdhNBz7dYkHyzdpYflcVxSeKW53zAQ61ezpdpvR3zgewC+2/T
	gCcImdpsCcWaw/FgARWvLhq+qQJ0510hRkQs7SBVv5dbWmWkfFv4c8zav+Lh97e8SXXSZiKAukm
	b68qx+vrz98YZ13lo84ssNsWBdwoahpzNmVIqiQjgXQh+h6Mn6BVb8uw9semt/Xj4F6FVO8FRcH
	l+RAIq951feJ6dWdY38qMEiS9N6IwygCPiR6wDGrU3NPmyeHZ1lcqIlRHyi2tVmcqEd/HyoBSsb
	LDop0XBBtQJyAC0PrQm/PjO9JuoJON82ELC5Zfjmreq6LhrwuLqMwwbB2ZefTrrRMU/SdVmC/Dh
	b4lONF5lQIYcQ52rGukdgBVb4feRLfK/xRM8UpoqrZYRPCIINLD+qWwWm2zmN1QhYxDQ=
X-Received: by 2002:a05:6000:4312:b0:48d:f36e:fbcb with SMTP id ffacd0b85a97d-48e6e2eb205mr40183789f8f.14.1793813089158;
        Wed, 04 Nov 2026 09:24:49 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda20935sm4836773f8f.54.2026.11.04.09.24.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 09:24:48 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	nh-open-source@amazon.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: Add helpers to allocate memslot metadata
Date: Wed,  4 Nov 2026 17:24:48 +0000
Message-ID: <20261104172448.66264-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aus6G5VqWJv1gq7U@google.com>
References: <aus6G5VqWJv1gq7U@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026, Sean Christopherson wrote:
> Split this into two patches: patch 1 to add the helpers, patch 2 to add the logic
> to pivot on INT_MAX
>
> As is, the shortlog is comically misleading.  Pretty much anyone is going to read
> this and assume it's just refactoring existing code.

Thanks for the review, Sean. I'll split it as you suggest and send a v2
shortly.

Fred
