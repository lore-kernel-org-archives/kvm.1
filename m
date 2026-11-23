Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455141;
	b=Mfwr1Jsx2hCNfBwxRxa6ZQz0MJcrAsX8Ur4hekh/kG71VypkGj2AF4iUMAKrjUklri5i
	 jjjeDgDlCMMYxVEAJ8qPnVvvJwsbFvNtOuy4NAIkpMR0p2BVl8wSerkjB35PmFpciWVt1
	 a65LU0xS3CYLxc0s1d8/EM1ZQXuQhXRvLmvvOUPKbFx8bC8mYMbGLve9TelGdCULw6TTm
	 7fvwaNKrNefB37axu/3JLbn4nBIK4nK3C66TIV8yXYHRHlaMS4FfBHoCVCbdYaCKHNlpV
	 x8LFlnnbO1EFPUwettiZhprqJg/FAujE7+mQDThKhN7NrxL6hWcWsd52Teqx0lXttVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=P+l/VRR07HqPbgm9tEPK7SVr6Tlf5vY5XKwCiYVXpnE=;
	b=4M89ukzCV8NOPcb8j1v2oaJ6ALANepkkl25H9Y+lO1fmCz9NWJt4vw/KilmlScaIJzUS
	 lufY79qgGrAf4Jx++15mOVpukAFd4DTK4Pc/5NnvdNr7UDI2iLrr13wdZaH2QmAys6UcZ
	 J003kal0SLn9w22C2vQ1KWVhsnF01sxrXN22q30S8x8DwTKAreleuPq8wrE1WX9raIC14
	 T70QW7usUFY4WvqkQi2HbAQX7XmJ0RH+gUwurSGclaLR/SFQAFtSTDS1tEVA4xrK88xIw
	 YIHy0AKyM0mcYBB/bWnEks9LdNwUz7Osx1ti03jJn6P3hiRsn8H859mGguKUrNDcKEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GUqMwfdW;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223D606A321
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 17:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4223D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GUqMwfdW
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f07a960666so16497135ad.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795455140; x=1796059940; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P+l/VRR07HqPbgm9tEPK7SVr6Tlf5vY5XKwCiYVXpnE=;
        b=GUqMwfdWySOE88STspofkPaLQaaZjEwFfhZBDcvXCKXUdwt0IqoJuHyz6c4xJs/dnO
         RLel3qR6lTtHRWvCqUUH6V5nO10hZZlnSxyrXXoEH6W8FwXVOVGLxiAv30EQ6HvrMt1x
         4gFCm0+JmjZI5aW6RAsyZvO6EbM46xOijpgUC6/Gi8xQTSRJxGbSJwxabd7/tnVmiQXO
         v4nAVDKIubL2xTU2aRRz7NEg9/ux/TdNw2zEhqyeTsdVJAu9Sgw1uALVn6Q6ZcCySPur
         zNiBzRfxUKrP/aEvbxj+n/QxJwBzo3JvMo7sIRnvm9/J8aQiFzLnERdkb664faMxpA5G
         xcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455140; x=1796059940;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+l/VRR07HqPbgm9tEPK7SVr6Tlf5vY5XKwCiYVXpnE=;
        b=OqAeVZc/dGoxe6wwWir+xoNOnhWiMv7Yfp0HiR0qnCI7hTbihVbQl05mDLCnugLKTC
         8UB8H9io9sEmwFtFdm6TKRSHrcV46Jpa6wWbgjn7QRsV1npAY26lHJ03+yVA6yLFkWNe
         /RtzL75kfpmG5Pdzn3q4CW3gn+cr5vIT1/E7xoIgZiKR5I8hFejFzDm7Efz0bBm+A/s1
         blpEDCJIjFECk6a1jyvIdkj/BXSyinlxtcM+NzmrgJvmRBQfOHHt/2Ze0Fd+XOKfYLqE
         VQr+Rx6kzdAzYEC5pxbFRjGrAPvp8QlpayYeK599pfRT2Eh84MGNY85ulhmVPzxyCWNf
         +mQA==
X-Forwarded-Encrypted: i=1; AL+hErHMolJhoTyaf7E0C67Jst2NwAOS2q/96UqMrRerSwQlYv3gWywPz8CzUr37czsSWbUTE0Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9y1VrLOq93sVtuIw1M+pB5N8StGS6wtn/LSX2z8ZA8p6W3TXQp
	hbfHdk9FgED3sHZkt4yqfaP9B5eQmXe4gG/vbbrfe/+LQ+vocpcB7LVrL5KMWzXa2g==
X-Gm-Gg: AZFdTZfVwIiC8HPNG3qocPdR2wLnyVx6snArojKVf1AkafEieFYQUlZZ60kXQSrrw7W
	oS6gLzAVM3JkbnN3N2e9P3ffgTabawY+3V7Wzi+Wjiz478Ab7dUM+hF7OasIMyfKrqBEOHz5ucd
	K3NLT6Yayyvw84oUvXklgIJm3MiHObVPfXhPb1DuhZvHzGpldCfP3LtLP7S9UhwPPTGuwXAlQdT
	r/CRZyALVATh65OAdJC42R+zMUY1rqBYWy0oJGWCWcWdSGoZ7OFRYjSppC2j3opihB6rRKUv7vc
	35ks7rf0BLt02CpmIaGJSv4SwzHWpElxGNUCs3z1KclPR9qM9VjYxI6OkmH5O5UlcQkPnCV3l2x
	XmE0tboJ6DHBeFd95WA6pvVmx4QrlKmzxQMiXlZ5XW0JlXoaqmqR0Uf/0T88hRO2RE4bbJbEweo
	ou95YGF92KV7brGndZON62tZTilbvI5+blkoB14unbc8CrBagJ7W31KpbpKcDhDqvU7Okb/8kFD
	kC+MaHo8+HLMRk4b57bbdQJoADfvdikTua54OF3avh/iRjRBF+4FDt0Rn+tR6hw9B8m5Glh43us
	2BEbvwSCD01wZqQt4FxPF8ZtBvxB/B4l1r9HeQZmUYxxX2RU4zjKcPI/IfeN9VGt
X-Received: by 2002:a17:902:e807:b0:2ee:1fab:158f with SMTP id d9443c01a7336-2f03f167d4emr115089865ad.43.1795455139780;
        Mon, 23 Nov 2026 09:32:19 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f051a566f7sm45650825ad.41.2026.11.23.09.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 09:32:18 -0800 (PST)
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
Date: Mon, 23 Nov 2026 09:32:17 -0800
Message-Id: <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "Tarun Sahu"
 <tarunsahu@google.com>
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport"
 <rppt@kernel.org>, <robin.murphy@arm.com>, <maz@kernel.org>,
 <will@kernel.org>, "David Matlack" <dmatlack@google.com>, "Alexander Graf"
 <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
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
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
 <2vxzse0rzjdn.fsf@kernel.org>
In-Reply-To: <2vxzse0rzjdn.fsf@kernel.org>

On Mon Nov 23, 2026 at 6:56 AM PST, Pratyush Yadav wrote:
[...]

> When we have all this available, I don't see the point in
> differentiating between optional and required features at the ABI level.
> At the ABI level, all that matters is what the incoming kernel
> understands. If the incoming kernel does not understand a specific
> field, the outgoing kernel should just not use it. There's no point.
> Best case, it gets ignored.

I pretty strongly disagree.

An optional feature is one that the next kernel does not need to
understand to correctly restore the object. A required feature is one
that the next kernel must understand to correctly restore the object.
Optional features can be enabled without any compatibility concerns.
Required features must be enabled carefully (IMO via uAPI) to avoid
breaking Live Update.

I agree it's a good idea for the outgoing kernel to check that the next
kernel supports all of the required features it is using, so the Live
Update can be stopped before the kexec. But that doesn't remove the
need for the distinction. The next kernel still has to decide what to
do when it sees a feature bit it doesn't understand, e.g. because no
spec was provided, the spec was wrong, or we kexec'd into a different
kernel than planned. Without the distinction it can only:

 A. Treat all features as optional, which risks misinterpreting state
    and corrupting memory if the previous kernel did not properly
    validate the next kernel's capabilities.

 B. Treat all features as required, which means no new feature can be
    enabled until every kernel it might Live Update to (including
    rollback targets) understands it, even when those kernels could
    safely ignore it.

Neither of those is a good outcome.

> The semantics of required or optional then become "can I describe this
> object with the capabilities I can use?". If the answer is yes,
> serialization succeeds, if the answer is no, serialization fails. So
> with this, KHO_MAP_F_MULTI_INDEX or KHO_MAP_F_DYN_DEPTH are indeed
> optional. All memfds can be described without these, they just will be
> less efficient.

I think this is a different meaning of "optional". Whether the outgoing
kernel can choose not to use a feature is a decision for the serializer.
Whether the next kernel can safely ignore a feature's data is a property
of the ABI. KHO_MAP_F_MULTI_INDEX is optional in the first sense, but
required in the second: a kernel that doesn't understand it will
misinterpret the map. The header needs to convey the second.

So I see the spec and required bits as complementary: the spec lets the
outgoing kernel avoid features the next kernel doesn't support and fail
before kexec, and required bits let the next kernel fail safely if that
check was skipped or wrong.
