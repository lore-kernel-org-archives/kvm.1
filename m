Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546936;
	b=Bih37etK0qztxrbyYIHaVvFUu0cKMRQOarZftiAYHHTy+TblBVfUoK4VkSnJuoSmkZdU
	 W9rLmLPRtu8Sb9ZOD+msKDXbmSXS8LlA+/BaTujiRLIHvisNHh6LO35rvzZ7kb1eneoo4
	 l1VDYvumiW3pvBqEK0vwNle4ZmiK9Th1YkgPJcB/FonybMrX0TWQZk4kSWbmscVtxQhCR
	 l3ahR+hE2L8cxZ8EEr+3HELc5xjXNmnKey9mLlZjjxM5KGyGPNTDrd+jAkiUDRCccW6K1
	 HZjlhfGuz8PuaOp3IGYo9Q+dsHzKs+RxdzAk1KSw32NDwetV8g8819r3XNcnPPknFQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
	b=Upd6it9QGaWWyXI6O7L+ORoZoTLLJOQK8Zfty76oM9mN5mWPPss0JrZVnyzTOE0RStTz
	 hp18YW0ud71k4zciYEO4Zc/YCcQ4oYie0Veflw13WxLoNF2lLZemhr+CqQleyuCk5i8wF
	 w/AjSilLZQv+zqQBCTIx6MtuxbdM/ui+fyQc7XZEANAhYxz1n+awbDC4aqXVRLlwKwDd2
	 hB5C1fK2AMDludZPmfVqQdkLhzgQtSkQo5Rtfn9nolvmlhOhsFYALuJycpZYKhmeX/r7P
	 WXJUVu3WOy2UjSEiNunKfmSc1ucT+h6s8VuO0k8PP5GKDNLnhtx87k/RcVQg3LCDH/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W49HLn5R;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE449606A326
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 19:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE449606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W49HLn5R
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso3091821a12.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795546935; x=1796151735; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
        b=W49HLn5RkMaC5OffA1iNYwWj3QcXjho4bBBEYyHJ80sMc/UPULZx0is/eDJpC2N3ib
         U5411fK9H7EvaHNUiAzyNcMRaRfWUePxiO5nF6dXRnWQcakCLoOcwBez1qwCR6R1oIfe
         q4c7EtVSFXNeliYrDeUDxIDrBA9ZIJuyG39lD2tcmw1MBgaf0y6E9eqLCYzDMbFPT8aQ
         T2II96TRsePidFGcPlSyAkLQbRIPL4z8RKR0PPlfzSoiEzHTM2cY+rkptgAAFD2Cwvml
         DpAfsAN2AKGhtv05DtjXMcA4gmT2Ub8TyWWHMBLSJzr10iAYvLD8v6nEW2UiNe6xEGzX
         AF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546935; x=1796151735;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
        b=Oef5x633QS+lTVUWPuzuJLRuW+y7wP0FKOTAArNJpHGTQh/8Z0hpMHPNl/TRS4Lt3g
         OaivV6taoTDYiByXvAlLh3vagPkHeJeqL0I70x/VcFPZotIT1QTunfVbiH5FBdCMwXW9
         n2lNVb3E6sh9pZzEwHBdiKO14+ZtIYjEgWp15FBkMpdVC01fh8Nz+MZVCe7M7I9r8jdJ
         MmWtGv7anKKCNleLhcUe4qh9o3hIO4BsfKoAoXoDLlXQ5X12xXujv+W4fRPqEOCqsAa+
         3qxj4iUtLDqK1jpEQI3rTGvi7yhILgVQ7P+dJWq2WLjtB9Zn7iezqFUKG3fEK3X69yg8
         0YRg==
X-Forwarded-Encrypted: i=1; AL+hErFDEHFal1p4fQzerr/h4LrTaKkeoEjsF909ql27iSjPOdilDmb+LmGbHkXQoiUWKgwIBmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9N5C6qnPw/FdKA4O6PG+Cv1xGvbsB8xGtGguGvODFJxvGj9Cfl
	kj0fDfoOCQFkDGEVclnlOoypI5GjvmlDYLkP35vS2ALt1BNMaqz9MheqmsSeG6j2Rg==
X-Gm-Gg: AZFdTZdVFu38d9nZ8qnMwn8RPxb3613YkOdPwtp0JH15D/fIdPOvXnqkbCHAoxPOn1K
	GaSDGmAAbnH0to8HawgDC01MZGvgshgjck8QC/5snhza38pRPihGHaraNe6DxqiCtQbJnYFG6tR
	dP5XklUgF++AGBjfm0vcwKvZNurnz6sn0SdpqWUkCjyIztjbrj5utWK4yXfbU/VqsvYojG0eADT
	zlAb4ti4cbFnHQOYYRB7M4cUl5w3i1zWZV0YKhkRoqCLfQD1EKvlTIenLtzU6MVWE9X8pnty2VI
	633eCH8/UtThNYXQiqxq2kaxku3frI7KPOS945Oc2oZGOxczhBuQUYA0cw1qDjrCcvQVTLypOuB
	MVdhir7nu5kVX2j+efQO4j8Ux0c9CHyc4evnvOtVArrVH0iR93izKTrRp6dWerpzPcyoBTX6syK
	mnx88l4k5i1vYDLIT2FqBF7AQ0WZfr7C61wxDNvDz1IJ6nl6Lhak1ThUuV1FF85/7Df2OpPfXsI
	Jpe0Ywv8YsPgqwNc8yAb5bcP9bkPEg5vP5VUcZqrHnfbuBbCUtU6yF0Ypy6YHJJM6R8W5YeeSJ7
	G8EkLONLs1X51IW/w+TwU0TdRQWU9ge7ge6/tLtnJqMMGyKyG8K3N4SCyS91oZs74g==
X-Received: by 2002:a05:6a20:a11f:b0:3e9:f2d:d556 with SMTP id adf61e73a8af0-4014ca44d17mr16159174637.55.1795546934090;
        Tue, 24 Nov 2026 11:02:14 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde9bb05981sm2247135a12.26.2026.11.24.11.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:02:13 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 11:02:12 -0800
Message-Id: <DN3O9LHR4XNH.1EYLA6D1F0J2P@google.com>
Cc: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
 <2vxzse0rzjdn.fsf@kernel.org> <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com>
 <2vxz33sqz1xj.fsf@kernel.org>
In-Reply-To: <2vxz33sqz1xj.fsf@kernel.org>

On Tue Nov 24, 2026 at 7:25 AM PST, Pratyush Yadav wrote:
> I don't think it buys us any functionality. It just hides the problem in
> some lucky cases.

Following up on our offline discussion: I think it's worth keeping
support for optional features, both before and after the spec changes
land.

Before the spec lands, optional features are the only way to enable new
features at all. For example, the PCI follow-up series [1] preserves
BARs and bridge windows using an optional flag. It's purely additive: a
kernel that doesn't understand it keeps behaving the way it does today.
With optional features it can be enabled as soon as it lands, and Live
Update keeps working in both directions, including rollback. If every
feature is required, there is no way to enable it until the outgoing
kernel can learn what its target supports.

After the spec lands, optional features are still useful, and at worst
harmless:

 - Kernels that predate the spec mechanism can't provide a spec. As long
   as one of them is a possible target (e.g. for rollback), optional
   features are still the only features the outgoing kernel can use.

 - The outgoing kernel doesn't need to consult the spec for optional
   features at all (less complexity), since by definition the target can
   ignore them. It can always produce the same payload, and only
   required features need to be gated on what the target supports.

 - Nothing prevents an outgoing kernel that has a spec from choosing not
   to set optional bits its target doesn't understand, if we ever want
   that.

The cost of keeping them is negligible in the current design: the same
number of bits in the header, and one range check on the incoming side.

The one rule we need is that optional really means safe to ignore, e.g.
optional data must not reference preserved memory or carry restrictions
that the next kernel has to act on. Anything like that must be a
required feature.

[1] https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@goo=
gle.com/

