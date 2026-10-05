Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EAF4854E1
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206467; cv=none; b=SLZd3EXkwkWWpcoyvN8CZDhwDk0yHucYRvIVn6zuhDKaCPqiyxuRfagvsuqEKb0OslbQZestcJ8IQKSQbM4udALqylfIrvC0x9AJwu+zbUOhRI6uElITj/HGVRlXWPVWaKRtuO/G0HwcBVkkmrg3JuoYNtZyUVVzfSNDoiLgfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206467; c=relaxed/simple;
	bh=SippWX+xoSkF20XXjc5MLFhzuRKSu+Feuro+st5YeiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMtKeSKqb5Zw2BOP33eGQXIRi8Et+sedWVqN/CsSoy89v72+u6X9XDP1qW3qTjUIaCGcbyeKi9wnv7ZJeU9UidrX221X+1AhBKs7cQpAfOeRkn3ympeMR+TApr2JLmyfNdzb+Hmgf5M0eQ98vs5nq6On38FASqqb+G4pQC6ahw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyvePpA+; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyvePpA+"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a4fbc5586so307255666b.2
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791206449; x=1791811249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h5zNn+04D/ADxwDdeMfBIdi2B0cMu31zTvDOOv1nE7U=;
        b=CyvePpA+5myhEw/neft3Qi0/VUFTYG5o456QppG2/5G9A7H9FId3WTbBHx92BbDih3
         4LHwzEeHMw4bsVoy4ghXYLnVyzQmc3Pt0m3C+oZcTb6uwWl7nasYTcIjezFXsWeu9zER
         thV0rkZZZxmmS8fy2eaY0H5qWPUpLiRUvK55PN6+JGLkJRFj1bbf2KPTnHhId2DS9ugV
         7Wo5kWmTBYhH07RDCvxKlHV1nwfMQkiQc5yYc7bHd0t9oNlr5C9+UadIxvLO240oDVQd
         HkiESF/uf7xSIHadAe3DnCy04kNQTyE/I9pVuX/PyyqPVdDsTIGcq+XqQ3i07SASQUp+
         byWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206449; x=1791811249;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5zNn+04D/ADxwDdeMfBIdi2B0cMu31zTvDOOv1nE7U=;
        b=P/WJpD2yAfKo1gnBOYI1RUoZO45ZHQ9LAWfDKPVplRqUavP7uOzkxFZCrGDETpVHbV
         ANl7UQHNuotyr1u884INAFnmbGuzmn+8LuAnqXJusZDxNJg4FsVj4ZaYVfXiG5eQKC+R
         hepP04jUS3x4XtI0c6NeGF/j+1kfys3OnJz6irrTUmCMhTqzMEonkZQG0FOmX1SJuUzB
         aRcvXRkKnFa90TxAb/IFOkQDh43MBJMqmMoNKbvbLY3zpaW2ppZk2zIiBTWj6KiaH/AZ
         X8VmaSL9oXAxgU7pkZ7vOcmkkW+l6TTEkL2Uc+ZB1kcuohQnzqaD5umUhlLmPWmCEa65
         5ZCw==
X-Forwarded-Encrypted: i=1; AKwUvBwcNGJ0QrcO9kdWx3xtYoDWk2f4XhDBXLk8Tv0poH8yHndn+z613XIbMxckwadC+MZUrFI=@vger.kernel.org
X-Gm-Message-State: AFuF++kMCl7D9I5XEJ/PtYD32zXcXUFrrx6+/kOZQFouKAF5n9tGNFTK
	4nlHi9LOBP+64dtMxEGDwMoRAyBblx2a7iwPmdAZMlNvzDashUsb2eXY
X-Gm-Gg: AYBFou34ZrIu/en8R+4zYoRIqyhkDF9+79nnmu0IuRYENkKzGnb9M9SfhRINZfhPnn1
	kdmhOq96TiPThD3zGUIgjX3NbfDDFP6/wfpbxZwQUTxto/OVnJwodydi+Rrf/RrSBWGFKPNZPi1
	TQ0P1wZnC8ebaporsrL857GT3dAfYs2GoiFxh0D5cbLxgUGyH21xkuhF0I8+MII83uhSRjEomLg
	a5cB/377RhCDVIDStXA89qV7eDK4IczH2CFuNDLIjjlvAPWHESTnUXCEV+gMdkvir6IknvFviWs
	G/5dwMr6i1oYeKVdm0s8yppZtf5t6YuRXkoyrSrJLh5TZXaORGy81G49F8XlRB/Ym6EPUrd7/li
	XfJE7rnZRvGHR2hGixPj/ax8Tz8Gx2akpByNd5CsuOlOCM6FEIEDpLlL8R3PhjHG1Cifnjuoa0I
	RW0+OfjhOTD0QJp7p+L38hS6N1lx76DyyF9itmlDoSc0zHcQ1Xa5+uvMmFIksa5miFhradvraym
	O7lCjjELtt2bVkP4hLWKtxezrR85GlPpB7ZkLn/mBvjqK0IIDW6NrxAIORuK1vlJ3zpy8P7e88o
	PBBMXgIU3QcV07e3RbhJaBPNz0aLDm4R/R4=
X-Received: by 2002:a17:907:9614:b0:c25:8eb7:f388 with SMTP id a640c23a62f3a-c2e4ad13957mr911322366b.17.1791206448599;
        Mon, 05 Oct 2026 06:20:48 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3156333a04sm79392466b.60.2026.10.05.06.20.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 06:20:48 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC PATCH 2/6] dma-buf: Add get_phys() to describe a physical run
Date: Mon,  5 Oct 2026 13:20:46 +0000
Message-ID: <20261005132046.30025-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a04f17cc-f59a-4240-81c8-29776eee3a2e@amd.com>
References: <a04f17cc-f59a-4240-81c8-29776eee3a2e@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/5/26 Christian König wrote:
> Well filling page tables by the importer is an absolutely clear NO-GO
> for the DMA-buf design, we have gotten down that path already and it
> took us years to remove this functionality again.

Understood, thanks for the quick and clear answers on this patch and on
patch 3.

> The problem you are facing here is that dma_buf_mmap() doesn't work
> because you don't have a VMA.

Right: the memory has no struct page and is deliberately not mapped in
the host, so there is no VMA to hand to KVM.

I'll post a new version of this series. It drops get_phys(), the ranged
invalidation and the guest_memfd dma-buf import (patches 2-5), and it
does not touch drivers/dma-buf, as you suggested in the PAL discussion:

  https://lore.kernel.org/all/c413710b-4c28-4ed8-88ec-aeb8c4482011@amd.com/

KVM gets its frames through the KVM-private guest_memfd provider
interface from David's series. iommufd gets them through a private
interface with the exporter, as it already does for vfio-pci. The new
version adds a small registry in iommufd for that, which replaces the
symbol_get() of the sample in David's series. The dma-buf is then only
the handle and the existing revoke.

Thanks,
Fred
