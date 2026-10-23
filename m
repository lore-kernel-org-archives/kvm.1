Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777348;
	b=tyYUh61W9xO5nZcdjXK64eY60LNQMT3k7NOuSAzoGO+B5k75j+m+eD+1Amn5uCiPbViM
	 U8g2GSSXfBfvhuyfTJR51J3HGGK8UYQ/x3NVExLvshr4prCvmUQ7X3Y1brVf9PgGluYfr
	 66so1+dNRZqRix0up1ZSrGy4rsLDFnc9HZcSqlo+xoQ/8WEsWOziPOcLL9FdTdE2tySMN
	 U3VHnpuXllbKmz+3RIWXs68hPc0EwXJOWfOIJhB7A/H/GlXnilKGXh3qQz/x9O5ZOyL4X
	 CbAFzeuqgSCGPsHf3/WDl7en6Qhn1JZdKNUJ3YpkiSyjMbKfirUKFMLoMEp69aPU2iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IArJW2D7DC4NrWDvM238weKBxrWboHP+GmGljUSheNA=;
	b=BVOvWHLaihjJk10Yl60DanWFqq5n7dpPLy7rrb7qggzyVbBU5rbEBdu8WW/1ZwzkgUzD
	 UZO7eeJ2ed1VgoYrlcT6EDw6mSTW3aNq98m6X+cUJ6Lnym7yYZBQeljuO3TJ+3uYDQxUo
	 Kz964gQnuYc1IOrMosSEVhfx9lsWC8wk/8XAhhVx7PMOmrV0SXRNunDegm57FyK9TWSsf
	 QvELUfVSKG2hQ11cpVBtWU/93ZkuiBzlhGv+QxXeFSI9TAmWZWGNcUr4mP+ta03oz5gD+
	 hGUjcwo1x+9fpVsCVoOxavzFIHvP6qEhCZHQnwPFYcT1ShHwk/+pjg4cted91Gms/Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEF606A31F
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 17:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFDEF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c45111bebso640478f8f.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792777341; x=1793382141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IArJW2D7DC4NrWDvM238weKBxrWboHP+GmGljUSheNA=;
        b=qE15pYgNtOgyK2wp9uhHmPW3lpnIrQjWDDouCy3JYbd1IPAGnpkiQ1sFjBCfeqsgVk
         11lRWEucebETVSgkVRwe4eQ7IHe8OlPrizWnzae5mEN51Lz7LmMQAvfowgfp7pp9VjSY
         8ojMFcQ8Y/cMXl9Vl5ClHIKs8MbSDwSpdyrxKk5eONs/+iNwEGuTjszhx81xmGle2j3u
         5SttvDKVdVVC6L1H6oJIFjikyY5gkiye6rcli8bFHH5Otyy3QtD+qvimrzBlONJNZ6SJ
         X5NX0lfRgpuebTW3dXrYQ6ah5QMTrTT9+wd/GIR0AgncOrzQqe42eAZ9koOBhOXDH0X3
         DVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777341; x=1793382141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IArJW2D7DC4NrWDvM238weKBxrWboHP+GmGljUSheNA=;
        b=NGsEVFjzyHoYI3wOu95OmTA6pF80ZkpGb/lulHh9TpZK4jMJcZnaudEBTlibbuXpvv
         LlMsS7kjQJYrc5iWao1xnur0LYhlhzq3hJDoI41fqSgM6COy7O47Q+kVELP25bHclUJB
         QH4LmL+t/90W8zY5xIP/mfuV8DPgcK4mYdQa6E5FDrcR3Jugo6yzq8m4PkUPvlZ+p8Bo
         LRjznOzUpnvFMLlswBeAUujBkm+W53y+KjI+qHpavZRB3Rxl5t2Vj4gAiCbDUOwsoMio
         BalNXBal3fsx9LzzmaW6GTE+gljm53LqSK8rClYlBGAg+2AAGFz9JwuVak5JEPB5j8an
         gqPw==
X-Forwarded-Encrypted: i=1; AKwUvBwDcr5Aeu7LnIDTz7z5gosSilXAh5uY35unxnSS++C4Ol3OfpbGIFhBFSoxapWAR7zB0xI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ87nbSJJ4u4KEncCdA0xit4ZSDuo8z4U4ThGS1TGe/SiUjYBLI
	t3f3qnew3TN/LGiDayoy634GeSwELzqhLg5KRtvj8fIK5QRaC86fmCk7
X-Gm-Gg: AYBFou3rfuRbL6496uw3k2O8GVIkc2KQTIulsKa4X9l9FGUfO2fxoLTb7DIW+p2pw7g
	BUYapmg8j0fzXJH36f2JHPQcmGSaRrqDtHdsRh+aoiJn/rIYU6QZmKoo7EEIVysHEwVESTHXp7A
	XIiN9p6y59cXJ7HY4wKUUek2AwCKxNKI4s3L4oL5WoSShaQx4S1VvT2atUWTSPlTPbKoQVbd8l5
	82vv02km1b/2fryE6wumPcjrbOtf2D7VULP2H1+2z58a2ep7OzZUOojfYey7H47B3tmCbB3/DEh
	KPTh9KQVxwxvqtTOEcDwaZ/2ZCr5kbr3TTYC+DHA9h7/0y2A8+yuLtmpGPI3xbcUCPdIehi1BxS
	kmfWLrLLmR7BEksq35d9LFtQM/KIFAD3XRDcsx1lpzCoIprJe3YwFwqbkKkLGqsJ5i3tGsVyXYu
	A5tB3G2+s7r8p3g/wu8D2R6cMKzSj+DgDogqfeOVH2zNB060QDhHN/MVBpFZSiz87qVlpDvH/WK
	rXefDnR/pF7Fz72A1ZKolHR1i/rfEAatOY0noWrauSB3SXK3GP0Uwke9P3Y1OFZXYKqzsUWT3O+
	uLdCjBtKSnm+4uNHkqzCliGkfySc7tf6N6mnlCIk7RPREwi8mfTe5xxUy4GExj3jjSnqmHC4wxS
	2GGxSJMc6j193sAxG
X-Received: by 2002:a05:6000:98e:b0:48d:ea67:79d4 with SMTP id ffacd0b85a97d-48e385af0d1mr4196895f8f.53.1792777340908;
        Fri, 23 Oct 2026 10:42:20 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d40c182sm1118217f8f.34.2026.10.23.10.42.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2026 10:42:20 -0700 (PDT)
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
Subject: Re: [PATCH RFC v2 31/50] KVM: guest_memfd: Support getting PFNs for stage 2 from providers
Date: Fri, 23 Oct 2026 17:42:18 +0000
Message-ID: <20261023174218.54790-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022-gmem-alternative-providers-v2-31-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com> <20261022-gmem-alternative-providers-v2-31-5dd1dc6c660a@google.com>
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

> +	if (kvm_gmem_is_pfn_mode(gi)) {
> +		r = gmem_provider_get_pfn(gi, index, pfn, max_order);
> +		if (r)
> +			return ERR_PTR(r);
> +		return NULL;
> +	}

The order goes from the provider to the fault handler unchecked. MPS
reports 0, but a provider with contiguous memory won't, and then a
fault can map a block that the gfn and pfn aren't aligned to, one that
mixes shared and private pages, or one that covers a page being revoked
or converted at the same time: only that page's gfn is marked as being
invalidated, so the fault doesn't retry.

Clamping the order in kvm_gmem_get_pfn() to an aligned block of uniform
attributes, and widening invalidations to the surrounding blocks, would
cover it.

Fred
