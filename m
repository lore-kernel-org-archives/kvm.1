Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2B22CBE6
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292946; cv=none; b=t80zGbqJ04okyCejjtf1ymTtTTme2OJ760PEH0dzUW7DElH+IMcx227kASIw0ZZy9UjAMSOJhVwxPNyermoa1KacOgkSO3m5UjT/EogGfPh9+QUEeQ1qVI7UsL4M2DFYZ79KmHXwozLBszRKyRUGnponUEnnmKrG8AoTeC3OthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292946; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSZDiO4Fp9rSZ5VdZaGDwkSoFeUGBwQCw8xTKxrD24ewjDkHzCN0e4su3bITKoNm5dC9lFD0Wht4S30JMUehqykzPyH6NftfmIr+xgyLfWiLeJjzand/ce/hcKPenHcw5oCfWfEPg+34hKGJj3dGXURbzvoX2lVU2T+ysmN7FMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIQn2Vvi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGu+vjrS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIQn2Vvi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGu+vjrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782292942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=jIQn2VviiLkf1AEbHfgS4E/hXbaafu13/3i7xJzui307ZknKLcqFXupqi+5TYt19V4Q1tQ
	VReDxoMg9In+Y3Yw0TDFB4/pHUhpufHkLaucChiJwq00eNkFb2ZdOTJdQqw/jSq1RczHEO
	RnA8h6GYWKFau58CAlc1oBXf8Imsyrc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-cVcoPPImNP2bScPE1gDO4Q-1; Wed, 24 Jun 2026 05:22:19 -0400
X-MC-Unique: cVcoPPImNP2bScPE1gDO4Q-1
X-Mimecast-MFC-AGG-ID: cVcoPPImNP2bScPE1gDO4Q_1782292938
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46315372c3eso572218f8f.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782292938; x=1782897738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=HGu+vjrSWwqJQFW0lCd3GkEiJh40d5NOPgGYWlSyP0oQ4tQKFRgedhppy1V1jCK8jj
         PJ6ieeV3s2jlRBfi+EZc+JcClZfGekJ6FtWUaTPRqhHuA7IBbzzT4Q54ovE1UfG3ARZ8
         1Q/xwtUKNsAdW/gsOZIUL4Rnzkl72JnM6mSRUpJW3XIJ9BFLG6PvJU6oA92A5mNa9wZN
         CTT1/HplG3O9nAw9BNV3iq4JAyeyvEgWQDAqialqzvh6i7fWSI9CZv9daUEAMEhvqdq+
         ZRVGxV9j0dxq4H36gL1TAh2WTEWze3XML3HwUdJKmnoCvuCQUVIs0wU4N9i/TorKLMk5
         I7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292938; x=1782897738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=LaYNXU3OvRVfYEFtpNpLiOWocwRSfnKKDZ+X7mps49m7D5UtJII7VSzFhEVhNy7u13
         DK7lVC2RQC/5JJyZxJItVCNoqv9CwU34ggZ7OzlAJhEJP9LNl7IY8ewbOfkuc2ykWURK
         HAGDBtr39pNZ6UIPP5RwiJDQ45zGlXQyB+1cwouQgQ9sratJ35ib3esReD7MKfuVaobE
         w+eNvD8LSfaupFnOx6RM5RaUyh+f3q+AV/q/8dpScoropWunHrViCCPJQIhdR2oRLx0D
         t+mzRSBUywbLbWG8XXVlzqVbJul5S6F+fRo4y/d+BQiuVgHM1G6rtnfaKfTffZ5N5y6q
         nB1w==
X-Forwarded-Encrypted: i=1; AHgh+Rp6ck084sMXoZgop5YFtvlS/IB0qd1eRZGzUiTKYx3E4mnTLLVHpyW0g5p7jurmVhFGhKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaKXJsS5ib8ltSxsetYJEXFM/HrLB2pdYpfyWMMEBaLPVoxO5f
	YHBdar5zidUOU6P7oG6FM4Y78+0SzmbbU3tpj5nK2pGbwTJgWCa7fTEQ1CI9luUQgA+5l7D+N/x
	y21o1YMlO7Nq6SwOVZoJnvPSk4DIikiDQQTv9B9UJMfag4gYP5N5gdA==
X-Gm-Gg: AfdE7ck0u7bhQ5qhhx0jTZiI8kSYyT75ma8RCIjZUDyn5br/ViQM1au6hpjqVW6ksK2
	CSPR7ge1FJpNDb7jm8TBQxtxrLGgp5JxIoN3Rg7uqIhl1JJBeGlJmzkwMbT++2E/BdjEnhMO+bs
	2fGlJCj+vH/TpMLWbbG7TU4XkWZzLPJ+v8FRZKLtUpxivbSQWHtBAJJ/Tah3zCErrE5+S4s+4i4
	E9HLpYu9IWh24hYPknjwWu1TLVdoJmBkBp+0tFhGzv4kY2TEtcJaYnXzb0XM83aF7lRxd+vB0c3
	3bDPUmeEaosIHNS4ZV/VFLCSAdAZeHe1hKi/zNQlx66pYVl74CDP/Ty23kHK8aKsBl4xU6Cr3Ta
	vjkM19t9HhmNtmkDfIlcmfPV7HY2FcxkGm02HZpLVzisnYodkzxK561b/KoMsZ18436mBaG8nZf
	So609AmuthYniGRkjP
X-Received: by 2002:a5d:640d:0:b0:44a:be4:d0e4 with SMTP id ffacd0b85a97d-46c0b3e36b0mr2911080f8f.25.1782292938529;
        Wed, 24 Jun 2026 02:22:18 -0700 (PDT)
X-Received: by 2002:a5d:640d:0:b0:44a:be4:d0e4 with SMTP id ffacd0b85a97d-46c0b3e36b0mr2911063f8f.25.1782292938077;
        Wed, 24 Jun 2026 02:22:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46caad603b3sm1915438f8f.7.2026.06.24.02.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:22:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>,
	Yosry Ahmed <yosry@kernel.org>
Subject: Re: [PATCH] x86/apic: KVM: Use cpu_physical_id() to get APIC ID of running vCPU for AVIC
Date: Wed, 24 Jun 2026 11:22:13 +0200
Message-ID: <20260624092213.970091-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612185459.591892-1-seanjc@google.com>
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

