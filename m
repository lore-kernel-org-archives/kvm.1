Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589808;
	b=TDTlvysdbX3mECK+g322ZQub9ysSs+vz5XRu2h+W6PjgcT1zMYOlwuNGPZyEz25bY7Bh
	 4dykgdgdiiKC2lwcEu45nV95ioNN3iZbZghbZNwW9XBmcuTKiqGR58nlgbtz3Dx1z4HzB
	 /8YcfuOoLIFbKGgQJ+PCbC5zdioyZPedc74YdZFIlOw+gyyija8vLaVr0BsCdZEr/Jq+l
	 6NpKqFV7NDgXJGBNsbY/DDp3N8CIptGVbPKfKHrz6ZXbemQJgRrxI154Hqon4sqW/9VbQ
	 HMY12+MAWzLV+OpIAnbRbu4D2pjuG3eMygV1wdLgSA2DovCbTvSGptdOZzis/P6OY9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=FprakhUf8NJ7i/pJUhVF+s5uu9taLAIMe4T8Serof+A=;
	b=PzdnrPd18rheCyj+JmQJKzHVr2ip6Ijnrh9lHtknEEaVxqF/JRodV4vRlMN5kvh4OKTi
	 1M16z7mIDfL8zIL6+U8TjU1eq+zbtbBy9ZAKHy5HWgL7ShZdGAfa4nJKRdLvxZ91/WUUP
	 WCLfb1q+ATOTGGsMPpb2pHE+1R7Y3A2w+xA+9eGjcZzFkSSiz3RYK9snPoCykrTd6x1Im
	 a6hbyR7GaVXZzC0Y4lVimgFEA1gO4RJd5rmo7jqZn1QEgLCVAo0Pb0shXRTbe5t7EwgcF
	 s6lEUozwl8N3uBThuk57qyTSC38ra4dN9e6ktiEi0sVpTbOkPCXHFivqLD5xD5pRvNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=RlPZXaa7;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E8606A6A9
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC0E8606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=RlPZXaa7
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e46e449e8so3431089f8f.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589806; x=1796194606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FprakhUf8NJ7i/pJUhVF+s5uu9taLAIMe4T8Serof+A=;
        b=RlPZXaa7fe7EQZlpHI+2GAQlXvVlmpHFOev8m+dtEjaz87EYAL8kAQJNFvcebnJnCJ
         QayppHZcapAX1zGtIIZsMb3RlEGPDjqVmWDvVCnvzPYoTLjBV9ke6fhmRYjzuIaAP7jA
         uK7+gZzUDH1J8jBhKFSXooKzUaz9d+QZLs7K7nY9iph4N8+4JXQtNDxgs+EMim1wIgD6
         3tmYEVVTb6u68vD0HJXKScfYOusBlvBMoLIrGEGqC4lPbYcn7H4MFr1XSBLw1XgIUh2h
         xgqu/Fuyde2lH67JzlyZNxMTaIY04TI3Dwh75KA5/W7iI/mh+UWUbKewCi1k6FPdGR+x
         yANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589806; x=1796194606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FprakhUf8NJ7i/pJUhVF+s5uu9taLAIMe4T8Serof+A=;
        b=ehWj3GJ6a6Q11cKnXzCDdfZd15rz1Mm0vND46PIMG4ZeTvAofYsrHAM2u7ucQuswi9
         LjubBuM++rW4ZYnu002oUz7fnY1/zsc2JYmR6oZxBEFQJOXZtEGWZMsiuWm5CQ3c1dMa
         LPClpfrnpPjF0mSOKTqYm+EuKp+UTWP74NLdVGq4tyBM0MDSRM/vuHl4ar9F7WNRDCYY
         5AQv869uNTYWTaJj5mPwMgRCqr5ttlxm0/5UIM8lhwpKWbY+ef05Uvhgfp7+0ajUeATa
         d5wZEjod00N9IdAT1VOk9y6x1uvUZ0xGwZK+XY6VI08y37plIE96nTiJZ0xkK18UXrfG
         /szQ==
X-Forwarded-Encrypted: i=1; AL+hErG0Sw7KrNb9cN0Xx4QZbNDNec3LPIBNdxQdkxAMInuF+8JvbIMfXyxarkgKJN9cwEK4xRA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hgYLAl7LqpUh6pp6tlY9TBmrlrlwYCUKfQTWUgyEzkrvG8js3
	UgJdxRp8Xpmc/numMFIghE6a4jcs+jM5X+bdHVQ2Z9NRbE62/CvZISaWmUDG6qR0x3o=
X-Gm-Gg: AZFdTZfom1b5cTL3gj/iY0FtlvFRRDJF8PXHCKTC/CHBgj4C3fl4hdG3y50Ki9T6neQ
	kPdKdQiiTmF9JztPYrlBUL3ownMvAV14+apS7P6JKGxjI2zUQRyus1Yqo6OLOzCfQt3FDAd3Qwp
	xpyeGIiwGxdWALWkDzhrRXLba0ZlNFx3yivK0FEftxmScpjkWPdsoDqKRpD6FH6FLEiBm8ASU9c
	kTf4y+NMO7V2ArjxNpHphx0EzPPi2LQSz9X8i8rF5D+S6DfBjnIMuhUwcHfXO9nL7dAyMEEPEjE
	rNhWfob2M+nHCl8ccdhM9w5BI7W3ecCnpOign66QeKnU3dYv55N+LU0hry/METtaBLwwinXc6fs
	1rAWSGXRRDuAA8PuYGO32aGWXlYhyXsHDKl36sVYFFBTWdRjPog7M7W7Oc0Fhl1cOom3RX336bn
	HLCB9+VmWC4vxUZh96Bw02YsY4x5tjnjrrR3tBSYH5b+BWtKVLtm8Uto9x9qxD8aAB4VkwHX4kk
	qfDPjwkDh7WJ/OZrZtsRSffQXnj8Dj+LOHv51E7F4MTo4OhQ3YNNuXzsr5lozreFPVyUER6cpfM
	orJSBu6n911KPw3Zq9o=
X-Received: by 2002:adf:e014:0:10b0:4a6:b87:d799 with SMTP id ffacd0b85a97d-4abb400bb42mr23914238f8f.17.1795589806244;
        Tue, 24 Nov 2026 22:56:46 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm29125406f8f.17.2026.11.24.22.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:45 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:19 +0300
Subject: [PATCH v2 4/8] KVM: arm64: nv: Discard nested SError in
 kvm_reset_vcpu()
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-double_exception-v2-4-224689d8a764@pereq.eu>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
In-Reply-To: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Christoffer Dall <c.dall@virtualopensystems.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Sebastian Ott <sebott@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0

Vanilla KVM stores a pending SError in ->hcr_el2 but nested KVM stores
it in the NESTED_SERROR_PENDING flag.  Clear the flag for nested
SErrors when we reset the vcpu.

Fixes: 77ee70a07357 ("KVM: arm64: nv: Honor SError exception routing / masking")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: New patch.  I split it up like this to make backporting easier.
---
 arch/arm64/kvm/reset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index a5d298d5ce61..d80b38b2ce6c 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -209,6 +209,7 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	/* Discard a pending SError */
 	vcpu->arch.hcr_el2 &= ~HCR_EL2_VSE;
+	vcpu_clear_flag(vcpu, NESTED_SERROR_PENDING);
 
 	/*
 	 * Additional reset state handling that PSCI may have imposed on us.

-- 
2.53.0

