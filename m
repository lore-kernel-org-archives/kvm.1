Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776556;
	b=dXSn0kAdRal/CY/HRap8Y+zyFFfeBODzykCRJn0FYGNSrNtWyVHCahU2mUmIopFgGZBD
	 DGY/Kc9S8sO+XT2Xpou7YmoO7m6+s78d+ygjdWTdIfOFDLI8tzvSyLSwSH+ZviufP2mPx
	 NpYupJeGnHm1DQdtTey3amFe7E5JhdH0qMzPBifPJiD2URW8j4WvCCGCzMIeAa8yS8oQr
	 W5wzQOKTo8ux8f/SqTHK5v01u1L/6PKQFhrd+zWJAQVd3tMRgQHCCHkhS4znPWFY39VKI
	 zXDSA5Pa+WlBNaniqn4Zb3mpZ/py8nLHKp0BFFUYsBSqxgZvrDWcWieX6SEDoMr2Aug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3Qj0y3/sB7EeSLYwSP8RPCK8AZrmLUoRtMMcxttoCbM=;
	b=yfVoMpMrG5m3h6fjBKl0MMNvOl3Ep264lsEH+WEGaU0xkwsNYxo06wupflKwgdGTDLpp
	 vSDTj5Xk9t4JcWYJyl/UDyjoI8H/qs/rKRNc2o0oTzhBJyD4aHO3Fc0eS2UzPsRF8ja7M
	 teBYXTKhio4yJJDDvKY6QENvTN46DMxt8IDJOg+kS+9OZ2+gMwK4zNO+aTOndiV0081ss
	 QGFdk+mOIDiabWV6+kK4csmVZbLaO4q4t4F5ev0JmHz/7EhKQVtfAt0NSl8/Ofqrdw1Zx
	 mGrwYbSfBTxHG9f9lHr/LIvkk5SJ3AOSZlaD18kmHyPo1JOBMqRqRTZZTHK8RtmGo0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FsXey+P0;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F6606A31F
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 17:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C1F6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FsXey+P0
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4d870d54so762116f8f.2
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792776554; x=1793381354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Qj0y3/sB7EeSLYwSP8RPCK8AZrmLUoRtMMcxttoCbM=;
        b=FsXey+P0eeIEmJhBgBeUCGTebbSsxCz3o6QZLKul+LrAXxI5Iq6haR8I+mfQ26X3rv
         jdictCITfezDnQnCYZ7j4HTg/tTcyUC/Drgp3vmWKgBrr8QxD8Lc9OWWfgyy8NXh/aVp
         FU1i0kULfGHjxWSDkzzHhNYPQMA22NfAV96rytMgupGsdGonuZFqafUHqB4ni9qYpDM0
         pMnX6nPNZmJtDzCa3r+7pjhGX+9lIH4WS1e9IAJRnvCXCHaSmtntU37q/aLnIzJzsrgt
         wez8tRl8q/zWBYrqF7uksh+EHPqd6RxIvPagUfBww3wDRIPgVXt5ZOLUSwxJKgSTrUuS
         E6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792776554; x=1793381354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Qj0y3/sB7EeSLYwSP8RPCK8AZrmLUoRtMMcxttoCbM=;
        b=jMSIfuHtOa6w06je+kQnBNooObNFnT0pS2BdLpgaQdxBx/lIto/ykJujOWSyotBevs
         3Kkg7h7ywH2zHESexGqyb3rE6d8U40CIhik9VE1SlIpIDtOFd3/aR7y2y0O6SlYjhUcI
         RtQ81nCosQ9HwhXHEmr4vq1vv6K/jFxcorh/Q0gSlXIEkfPPpdjiwG09q3Tm4AOeQoLp
         mwSuvnCFXIQMa5oZ9NpINDLTds76pGEQi85pXzWxuAojdoJf1K7S6ux+fuk/QOzXFriN
         ONFoTjcqKp4QPMH9ZJDPpKnPifqJ1PVpVcwqkGpeuvyDBePhTzjwx9k5T+gdTgnKbZ/p
         VmFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoWRANRJPKKjw74+DrTnzFLS0Jwd7NGnCcLn4lezR+EPZEiVD+HIJgtc1CEIsnmAkAn98=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+lslRc1tM6e1Kj+xUE7gCBPHcKjrD9GnkiZepAx/z58xvWV4p
	5UczvBXZD8LQO3lnkA7puS0KnzH6ULJr7HLdhkwzxEl3YdwixxL4Qmpw
X-Gm-Gg: AYBFou0Fp6ItRWy2B9f1PW0Dc61aLLr/K83a9CsnX6EQ+V2OLYqFkL94TfGFay6bhc3
	2gJVNyUAx/wm8uA+fdpf3aX2WWhtLyLuYkfwhkcLbxqntrwo68G1qWef8ilKSgn1pbqqS886v0S
	lu1DWLNdzQveppOkV5r+DsIrh6/Zat8Sd0aPeLAkMoKd02paZ2r+X7RqdQWYs2Ff3ZdBgwSnOIc
	0Y1696SvmYRFIMNTINQa1XiOYp3cts3OupNuHvYzkeP3/Hr5iucT9CH3+d4+bOrBtHzQ6VWa0ZY
	FqiupGByGDUwocHHSuj9X6PFYPl1b5X6XPMTydOeFYotvgsTIMhLNwcUytM10UCcrRiAosCdl+r
	zkorAUfnxzQSaawhU+CD/eeKL1qvhGscRm2Wr2ltChQkjs5XzRnsp37Zs/XhcLzx6TmsDaEYgl6
	KF2RiYLkXxYoqg6ba8Ueu/b5r17Ryp5Ypr9Irv0Kx1nuvjeHRSNvkRzOOt2JK3900HzIvZg/j3q
	bzyIV12tFWlDiUlV4m9SXnEkKB2KTltF8Ap+LoChbJQ99KFwF9mrsT9BddmAUzkXyB6yeHYgrkI
	V9RZB+YB/6YC987eG63TumtLCyIRMja+zCR4TZ66WpnF9/UAKTtRgnYZNVBvAq2wlrcPdbQqL9r
	z2mrA5Zs/aTVpDmIb
X-Received: by 2002:a05:6000:2004:b0:486:f9ea:796f with SMTP id ffacd0b85a97d-48e387d65ddmr4932292f8f.41.1792776554351;
        Fri, 23 Oct 2026 10:29:14 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4144f8sm1120262f8f.41.2026.10.23.10.29.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2026 10:29:13 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH RFC v2 34/50] KVM: guest_memfd: Skip checking outstanding references in PFN mode
Date: Fri, 23 Oct 2026 17:29:11 +0000
Message-ID: <20261023172911.17557-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022-gmem-alternative-providers-v2-34-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com> <20261022-gmem-alternative-providers-v2-34-5dd1dc6c660a@google.com>
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

> +		if (!kvm_gmem_is_pfn_mode(gi) &&
> +		    kvm_gmem_has_outstanding_references(inode, start, nr_pages,
> 							err_index)) {

In folio mode this check is also what guarantees that a private page
belongs to the guest alone. In PFN mode there is nothing like it: if
the provider also exposes the frame somewhere else, say a ring shared
with a device, the VMM can still make it private.

And it is not only this guest that suffers then. Whoever else uses the
frame breaks: an RMP fault on SEV-SNP, a poisoned page or a machine
check on TDX, a granule protection fault on CCA, or, with
SW_PROTECTED, silent access to "private" memory.

Only the provider knows about such frames. With an attributes output
from get_pfn() (see my reply to 31/50), it could flag them as aliased,
and guest_memfd would keep them shared: refuse the conversion, treat a
private fault as a hole, and refuse populate.

Fred
