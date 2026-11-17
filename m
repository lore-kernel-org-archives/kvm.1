Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925935;
	b=eT37Tp1i1WvQ8H8XeAcrHfX+321B42AGU/ZJyUdHbPGlqfQJ9Y4DQxKQxBnxYYi/OWse
	 tVdQGYVDEMQycwD4Vv8J5k1rmmFt+7cu5aj3dycHyukIgl5lywoAhh07p/GJI+NAnV/gY
	 mm0D0uY8zKaRz0JiXzTCTj5XHBANE5az53akE817u+LsNRaWrSkzviyQBiQmekjuRh17w
	 GjC+fGtjGgelnOuQtILxAxzmIHUPpFKPpeU5PYbLPEidf3WnE4eL/wgIQTatp1pcohIJ7
	 taSNxv7Jt5svy7Q3ehilv4NNgodaZ8DbmFNemt3Mz9c2+4we2Qm+azXldulfmGuPyRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=D3nGp/c9ERuihiWyblYj7YcY7eqF7eIZSBxt1bWzptA=;
	b=cX0C0sGRESBBHztQDEBgcyjEsSmBbzRuVsOoJ+L0PrEMDmApetES1ijKEyHw8cJAFSMS
	 G8ag5itkUceTdxsAe5RYBbaUfDe3Gq4Ev2i/qNszHaf8rbcHXsqqsBa6uxmaVMY5hpiPa
	 cbUAOTW+EfQaMuJgYm9q86PcZkXrsdE8zc5pH3HSe36bnqVKPrLzNRnbbjptIF3F9mITI
	 /8biE1vN/oyLhiet/XB4LZXVCh0m74QUtKlVF2/0PwXeCvFz6pnR4dEzK7b4ky0ZKLpMj
	 NWiEw+D4p+ycJSUfBr66MJWmq4btOKePMsZXwyNR9kcowBLdLqm/JXL7jdGjIeeTybw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KoCmeohz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC026606A32A
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 14:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC026606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KoCmeohz
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c00d7ac49dso7447e87.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 06:32:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794925933; cv=none;
        d=google.com; s=arc-20260327;
        b=D5bC7ELdmmvkO8ogX2PwEGLNzm1sC3TnfMuvE4PrLGMPeROxZVHroqPdf9UiK6Bz0O
         7/0dN1L+mIvnklHGWBYMUNIv0qA7m9QSRzunLkAFMExSc3nvQveNTH+lotlAiFqGeu9P
         1NkyCHkPO2fal1n9l56AXkWbhHwOwlc0DIN3bComR8vUfhYOj0U6Iu0dNMUiHEBXiY3s
         ovujKcaOgkJQwxv3o2GK27+Gu5yr4nfxTfFmGWrOVUkHGJS2Toq+eI9haL41pcC0MgU4
         P1ePHlzkfoKI815tF/dAjkHxgMOkNhAHSn91MEAkhx0JwbDOwtXl68IP2jGtOlTIbU2A
         ui+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D3nGp/c9ERuihiWyblYj7YcY7eqF7eIZSBxt1bWzptA=;
        fh=ShOtn3DH2JacjDhhRuDN/ZzoL2uaqKg1U53ZjQaTW3g=;
        b=Y2QGKR40Blbj+2TyEo6ZlGGvmi5eUyRUHJriQ9fyuM41R4JvINTse8TdmY57e4zmnU
         /d/3wUs3NEmgPdHpHkcJy/bqlAcrWbVNgW3so1Y+GCqyNfZgU4ObrCd8vZ6wuhQo7muC
         IkwUSwsKH3oezR7NsLz+F9TUT5E+MDmxBMXly/Py8uzPi6emxzVe6AZxOg3r1e2A1abH
         Rd837uzDKdKHcp5U3xRfWo+8+SKGYoFwNX/xtyuDo4UZ2OVTFzSrBPO67sBD4Fdb1ZGc
         2IuOwXCWCYjjhJG6hcuE7P/tLSXvgN8iKxhD0ZOvfzyBuC7ye5sXte8M4C/ChX1JTwqA
         l5eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794925933; x=1795530733; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3nGp/c9ERuihiWyblYj7YcY7eqF7eIZSBxt1bWzptA=;
        b=KoCmeohzvnR6QJRU9ePv2eAxWxwroupksthuVkMbtXcG7IVcOO2DL9t6NbR7jlcB6O
         GaxWgc6P2aFothBBRecXJkRAlg9LCKJ3HzjhAlIJ2Qa88MRzB6jKdzCXkbiQ7SAuGVCQ
         mybIPu617O101kLqtWC5VPzKK0HoAKquhFc/Qv2M7PFlHQUL6Hf9RHhaKS8tr3eRMS+A
         xey2QTUwSQzZrv7VB70CCctZw3tyKOH9wtMEZeq+RWiPlbRZvn6YbO+shgWgOmeH5sSo
         TAS1ICNHqC96dkbpSeJ8BQ4zvPe6DU3umNkVzJafDk0U35gAuVFw4yU5oQw4aSiAzr1g
         5LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925933; x=1795530733;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D3nGp/c9ERuihiWyblYj7YcY7eqF7eIZSBxt1bWzptA=;
        b=UWm4nEyzDEGisSSn5uJyRLVhumQBwuPDh9UOat6n7tZvu/3B6dKClr5Y28NYDh/6Xv
         0jTBQ1c9OL3k3SimYtNFAp1lbBDniDRduV1pIhj5wMZGI3bWgQiCuLzCvUMJ+2O1pHE4
         nKJjL6DK0uTo+KtgxhrCs4rxpMO9ylFx5MyoHcdHamRTeDoODp6fEV6RjIRq7+MYWcW+
         h08cWLxzuKbcO2/s03yNm0BKyl3ujg7D/P+vUA3zrZGLjF709E15C5RtjWJUspxUib5/
         MX8aQ56h7Q5zXJDBdYGWTRCTzYEhfIXAKeC2Wy4yyPi9KzQiKrlQowsWFA1pr85UN/Ld
         cndA==
X-Gm-Message-State: APuU4Z/y1bBpqHs73oGRRHR/wLOE2C1G/pqkBnT0iqpi3djImCaZ5pln
	ouAeoCQlw6DgcSOYtfLWoB/MLd/WxEFzsQeAA/vP3//NmL4T5Lf3o9cDUj6+LWOtvi6vdX7Ye4W
	sp4oezZr6mwqKrP9GccSuWAkA3Y2eNA2OSQrmoVZ5
X-Gm-Gg: AYBFou2AUk8HKuwHN6MoWFHu7IsqURI4unybgip3POThnZP5HZ0q4jhcQFuA/+dghiz
	1rIgMEunwToZEnd20YwGhJyBttTe4a9nxdo9ZW2Ys4rOb+PJxKzIA3rGimGMgSkfF06qnQjCW9a
	dOc4Y4tjJmd76sHSG96aF0+ZaoRrUla5V8hBUacXSjEFfp7mjOL1Vy9GwKyNbET+EJ+Rb3SRCeE
	g2cKMDeIbPtNXNI/H2I9K6EWlCvCpN1raGBhMygH71j8b/Pg3DBP6Bg6w02zLIN3/0HN/ujEzUs
	TlUwtOpaWvaO/gIr3LD9on6a1wwmISSpokophFIBD3NgQGLh8R5NPDffXi4iCZ64XUBunfYy10N
	Eyle5WB3rf06CIREDEFxNYLkN3VTkV6/GEIeWaLFveAqhXS1kPXo5STlIhx9Er8A+51H/Cp2FJs
	k/RnZxMo6n4UXYnJvAznWygZ4=
X-Received: by 2002:a05:6512:1111:b0:5c1:4f9f:1ae6 with SMTP id
 2adb3069b0e04-5c1a217f086mr135560e87.15.1794925932245; Tue, 17 Nov 2026
 06:32:12 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116164358.142785-1-steven.price@arm.com> <20261116164358.142785-8-steven.price@arm.com>
In-Reply-To: <20261116164358.142785-8-steven.price@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Nov 2026 14:31:35 +0000
X-Gm-Features: AclHuK8jwarv0Qdp1aWUBJu9cvVLVN2wG1yO28RoPz1SpZjEhJ3_zh_LKO1lzYo
Message-ID: <CA+EHjTwqYUBvhjF8dxqVA1mF_Qe1r2UZdwkZ+Zirgmm2um=skg@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] KVM: Allow architectures to reject memslot
 changes before invalidation
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Mon, 16 Nov 2026 16:43:53 +0000, Steven Price <steven.price@arm.com> wrote:
[...]
> Architectures may need to reject deletion of a memory slot without
> changing the guest's memory mappings. Currently, KVM invalidates the slot
> and calls kvm_arch_flush_shadow_memslot() before
> kvm_arch_prepare_memory_region() can reject the request. On arm64, this
> unmaps the slot from stage-2. Restoring the old memslot on failure does not
> restore those mappings, so even a rejected deletion has side effects.
[...]
> Move arm64's protected VM checks into the new hook so that unsupported
> deletions and moves are rejected before stage-2 unmapping. Keep resource
> preparation after invalidation, since invalidation drops slots_arch_lock
> and allows concurrent updates to architecture-specific memslot metadata.

For pVMs the invalidation doesn't touch stage-2
(protected_pkvm_vm_s2_ops uses no_stage2_unmap_range()), so the reason
for the hook is the Realm case in the next patch. Can you change the
message to say that?

Cheers,
/fuad
