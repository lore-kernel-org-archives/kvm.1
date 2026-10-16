Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960D40DFD7
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143976; cv=none; b=LgPm0JJpwd3Glys6/Tao7gmju0sYBcZM7inHug79hSW3uotG4QENlKJY8RF6e6I3c5RofdrANn+tnR9kDzlv9uVsBMV+Qf+Jtf53pem1dWDE0qoDX/Aevyl63haL6n6ustu9z5HUE7Q7j8nmjLPCtYzxZjNAdamhA25ouGbRnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143976; c=relaxed/simple;
	bh=WBdGcxWiDrcVKqaT6IjY7dlU/wWj/hMB+CXmv51CihE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaAPH12kN5qsTmWokC2+4BcxlgpTGTP1Yssg3yEACaNFb5bHG3/ii6lJWAgVImvOpXDLXfQxFjeBPIkdr0EarpI9v2Mum6kSrzSyL5B5lNci+PvQtiRYsbgiwBJoG5og8k8bsCWvSR3WDDcLmDxlkpCzlU2QEjjYrnTUOlwluek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEfSOoVj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEfSOoVj"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso4516953f8f.2
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792143973; x=1792748773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WBdGcxWiDrcVKqaT6IjY7dlU/wWj/hMB+CXmv51CihE=;
        b=NEfSOoVj58mfNWYWD0HBk9CT923PjsiXayk+W4diiizADUl5gWFolKCOmfHSVvTCs1
         +h794OQFcnI4VxGBrjRmYKYNPZZlEJeJKxFuLAdlqzITndINEspIxDSTinaJ79MIWPwm
         ON3UuhlS5KVtsmGhygxfRDhW/CTEVozMxOM2/ArIFPRUt6S4N3wHah3YltILTp3EtwHB
         mEv4ODp7kKJgpkji5pYf735jSa+T46G3W6B5bM/c41OsFSvGAOZQHdOOSgCIIyQUbG+z
         z+JuDj0XUZjZdvHkweJHJcGeAznwfFH7zARrpSGzvyeuSzPMKTvumLA8y8i0QK/Nqu8G
         ON8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143973; x=1792748773;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBdGcxWiDrcVKqaT6IjY7dlU/wWj/hMB+CXmv51CihE=;
        b=r8GEGxQp/D1aPJc9HCZNn2mx8f02H4qmhh2m2qEAwZy6SHHYUN/QYulwizzI5QrPNP
         KVqPOUZQKZe+R9FyGrhDXN356HuembbxOMQO0b3CCY6DuLMo3upJRVBYfUjLSc+gN+jU
         nBAAvExhesANi3+VaqnlsWmBeug/rZyaOe6JFqEJanBGk0JmfiLN4tWPSZdx3sI5LNJi
         3+XE6U7q9mrSbUOPERtfx8pFOhv83/Lt7E1rSQcms7Hz1di8ElqfaEDQBeIzgKX/3i9n
         8Lul+kx5yNO4LAp3w6TmINeHarfiWjiqp8uwxJXI2b65Z98A6oWaMzPKHLiRPftzDqu2
         bnag==
X-Forwarded-Encrypted: i=1; AKwUvBxxRtFjb3CYyN1KL9Toqkr7ShnWPeKM6fhUZLEcsycniYOnS2sgVqFmYH2bu0YzcILcOBQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3VMaTkEVkvsmz0eHcuC5AHTHfVCLju6oLp1GSVVIlLPg24JvK
	lcpWlkGACS+AeJcWgFJowa1yUHs2CpEyJvPGrzmHNIwdXD5AjjOrouIW
X-Gm-Gg: AYBFou2jtx1+TJnYM0hw0DXPFGMEjPb5jkciTqyhbC7AvsR1jU8d6geUqXv05eNfeut
	uwr4LtSvBnjv4zxRRRR3oc1G73FBH2VV9eSbThhtJ1TvnnKK3ExsP6j1oe+qT6Bz6a6MCaV8Z5A
	9XyENo2V8MZQqB0saS8ygJBFy4+2jJ/76UQdtkJOJ8bUEZyUxkRo9+0TuxOLNutYQYzh2Q7yt1E
	0iKyo8NaJkAUlXBn5iTewu7iHnyFC9qPByZ5Zm232TQ7a38sjUSEr+v/XqxgSRXBlhg9TEhYq2x
	UusDOIr9RI8c7p6Z7jLVI7/AX9ruaA+12cj6PJKkFiZwvTZ9O1scBhX0vecRQGvIEu6rbyFTf+x
	SGcC7EKgDBxlRlfQz/CpkzUreIT2/JaoQY3j30/6rTTHSaMPAOBDHf7rv7b8lIn8K/FC0u3cGOo
	llBtS/GQrsgdSVgM1fE4o0ZdWt896lwhVQ395p32loBSOzcVVkVE2nwACc77HJEbzXddenyyaR7
	4n/OAnMulO9GBKNzvdeWZ7HmLBwe5mRiQASITKtP8OxDe6JVrn66749m0eX4tv32PJ4r+AoQWwd
	p4IzlBgsjZO+yfNH6smC5JEgxicvWIQ1oFI=
X-Received: by 2002:a05:600c:83c6:b0:4a1:7093:40c7 with SMTP id 5b1f17b1804b1-4a18e493048mr406737735e9.8.1792143972697;
        Fri, 16 Oct 2026 02:46:12 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca43012sm17041055e9.3.2026.10.16.02.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2026 02:46:12 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/11] iommufd: Use large IOMMU pages for provider mappings
Date: Fri, 16 Oct 2026 09:46:10 +0000
Message-ID: <20261016094610.57849-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016001448.GC14213@ziepe.ca>
References: <20261014093733.90312-1-griffoul@gmail.com> <20261014093733.90312-8-griffoul@gmail.com> <20261016001448.GC14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Oct 15, 2026 at 09:14:48PM -0300, Jason Gunthorpe wrote:
> You are going to need to go into generic_pt and implement cut and a
> more suitable unmap to make this stuff work properly. We can't over
> unmap on conversions.

Agreed. I'll drop this patch from v3 for now.

Just to check I understand what you have in mind: a cut operation in
generic_pt that splits a large entry in place into smaller ones, so
that the revoke unmaps exactly its range, and iommufd uses large pages
only on domains that support it?

> Also please don't write commit messages with AI. WTF is this even
> trying to say? The subject is "use large pages" and this text says
> "map each page with its own call"

Sorry about that. It goes away with the patch, and I'll check and
rewrite the other commit messages for v3.

Fred
