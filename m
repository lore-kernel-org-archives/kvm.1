Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C330E0F8
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409025; cv=none; b=WxraAcvNqyk3ulZgJ4xqd9Mq8ua2L1VhE+s0kz4xXXYYhhvFwy21lN8lOztXN1biAwMbNYWj8NVaDM+cLR3WYhX8pAgsneKCcEyYZSbNKTqocAbbSfV6MrLMktC+67ZBTSjhFTWUVD0DHu9ivsHUFGDRFrnZCUz4dMFZpmNmQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409025; c=relaxed/simple;
	bh=z074bJO6OHWaI7OyPaH6/IPDvBnvlv9ayjdX6IUQvtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+02TNeyVE4fcRy3haUfXmeeSgzWtryYq3IX3+hnZ/FczAhjCIFNIZzjdihuIjYPCkc9Dy8a0KAQMOtSlzJA4GVrGnEc4u5RN2NhYZGYGtGfSid2QwS1xajixEVf4kJUV2nKGvJdllcuSfTnT+vWRxPLN9O8VoVPcS19oatqkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btq2T22J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXkNC36c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btq2T22J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXkNC36c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782409023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z074bJO6OHWaI7OyPaH6/IPDvBnvlv9ayjdX6IUQvtI=;
	b=btq2T22JWv1EduvtDZqIBwovAQt9Igx7bBItmNT41rQEhyfwdYJ77GGI6bAGI2etPo6LaU
	abZg5j9TtJ+cP7Ws+gvOtt85G00WziVOZS3h37dMh+4ZMPfqbzjuhGt1UcIkYQXCmdChTH
	nqmZOj1+A0panwsdNI7Dk2b1fEXLNPU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-iwwJWBfXOAaFINeksAeS9w-1; Thu, 25 Jun 2026 13:37:01 -0400
X-MC-Unique: iwwJWBfXOAaFINeksAeS9w-1
X-Mimecast-MFC-AGG-ID: iwwJWBfXOAaFINeksAeS9w_1782409020
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46db5d470bfso1775f8f.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782409020; x=1783013820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z074bJO6OHWaI7OyPaH6/IPDvBnvlv9ayjdX6IUQvtI=;
        b=BXkNC36cf+9xh+okX+Mrjy9EgaafmHFAwvLRGJMmwmWXpUufBzbt507Fv9k4dZyxwL
         rTHR16RuPK8o3hK6mHKezHNdXFJ4/9PFJohqFbfWSO4KleF0G8H60H8ZzZSUygK7p/ZP
         0jqleae9r2EtB3BobFdwjObQXf1qEpQ0hgXiP3GmMd2jW26b3BaFYfm0NDnMJCoKKv0c
         DOM3KZPXurR2xPqOu/rrlLpUEAWJbQHB/S31ld67mOSI4M0QenS6KPTKUCEELpboXNLU
         T/RKfQGwuqvRCiMhR5oCYkM0CMLguV5k3Bm6zJlU1Q1Hc6NRhEWPPIH2nDqECjR5sRtM
         gSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782409020; x=1783013820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z074bJO6OHWaI7OyPaH6/IPDvBnvlv9ayjdX6IUQvtI=;
        b=VHZ9Dq+wS7n3xCLGQvlA53zlmTCWhxN/QAVnWYUpvJ4zoWOZiG4NWi6VO+fWNsJ67f
         Fk8MSAtzadpbnjmBGkumhFOEK9KKTLqV85Pmi1QkwQ2AyO2/H5kT7Vy2QSDuGHCiCPgy
         r2/Yqg4uQHo00EFZ/C3HEbrAQP8OWbIIdwD7bmpe91+qWTFRuu1lYzGh6FCtnB0d1Vn/
         8a1NeXPOPJlYFjnLZz8muxJW2aa5xm/tbQlReOWALAt55qh4a6M7l75NoJsl4vIvTul1
         aoQmluQtt5B655mWD2aGvMy2GmyDPNEAU3DPlToaPAAcnl+PzDovWuDJhWXOEFsHjJn2
         eJDQ==
X-Forwarded-Encrypted: i=1; AHgh+RptWA7sFaB7GUyIiJencmMdMfCcwCBniioGpXUJxHAy1ejNgjOTg2adIAN3SNJGqM3B7/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZDzOL+ea4c0xrDm9ZmGyAwAAdxqW4LRJCi5Iz/dNIZR4pqbkl
	ZbrRi6oOQzRxiL1keMXtmRzLMmVXoTUecVwxhD5/Bb9Mods6UacVz4JcTr0swlnWabTnJQGUo+g
	FXHGQMYPBntMTl1mFefR0n1RtX7aA0lJK1kqSQQEd5owYM6Phk4BOdLK3D//u+g==
X-Gm-Gg: AfdE7cmEHdJRE/3TA8IUaViE/3uXqOALixTj1EwGfn642q+7d7GbisY5ahVx//hjHoA
	4dWLIrt9a1QXDy/nTlDukvOeUh7kD5PK/RelrgqxaEyzaUMC7C4ycoAk75nd3MwwWeEsD4yMptc
	xO60Dk60mmnSn+6If9Iap3EsJGeSyRlKWA7TEzyJWo3Fu1v/3neVn7lHsWyW+QKPGHbyl24F91c
	tt6hcP9qR+y2Qi1N8TTXMb1dMFB30S8ObFx3As+X5IvWhITrYhZOP2ic44WGcksaofYKaXSHo7T
	AdjoEyVX1YP3I9E0GoqRlo2VqZmZPhS8/Awa04qEDeuhsQpU/e4w5s1Vh/hB/P/vEeeXEt5HWAj
	Zzi7HkYj6qEhkGU2uxV1yUg8nBSNHRj9oo190DLYfDlcf0FCPrLDWEyL4rnHGKM0HbC0D6AvZzh
	QyTZN0KqveI5eOTeMq
X-Received: by 2002:a05:6000:220f:b0:465:8fc5:7f52 with SMTP id ffacd0b85a97d-46dc0e05344mr5737786f8f.26.1782409020369;
        Thu, 25 Jun 2026 10:37:00 -0700 (PDT)
X-Received: by 2002:a05:6000:220f:b0:465:8fc5:7f52 with SMTP id ffacd0b85a97d-46dc0e05344mr5737745f8f.26.1782409019927;
        Thu, 25 Jun 2026 10:36:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22c680fasm18026588f8f.34.2026.06.25.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:36:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 00/34] Add migration support to the MSHV accelerator
Date: Thu, 25 Jun 2026 19:35:31 +0200
Message-ID: <20260625173530.1624189-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I merged everything except:

- target/i386/mshv: migrate LAPIC state (*)
- target/i386/mshv: migrate Synic SINT MSRs
- target/i386/mshv: migrate SIMP and SIEFP state
- target/i386/mshv: migrate STIMER state
- accel/mshv: introduce SaveVMHandler (*)
- accel/mshv: write synthetic MSRs after migration
- accel/mshv: migrate REFERENCE_TIME
- target/i386/mshv: migrate MP_STATE

The ones marked (*) were the important ones that I'll reply to, the rest are
collateral damage.

I also removed TSC_DEADLINE from the MSRs patch, since it's more of a local
APIC register and it has a dependency on "migrate LAPIC state".

Paolo

