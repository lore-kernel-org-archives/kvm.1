Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CDC39DBF9
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644916; cv=none; b=DlL+s+6PYxUaIeWu27L72W6e4lbwhw71zmGbLZLp42D/x0YB31yFfz+qVDo26f1Iwj1XCLJYRKYtPM8SyhmA/upwIc4CXpC5rxb1O5GkWrzpJAN64MsAsWrwY6OnZYa6mGx6eUTXIvlydiSsYbytdW+zMbo398N1I0p6dD0saEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644916; c=relaxed/simple;
	bh=7fxUvQarsZza+ZSNU1G51Ztbl4ikxZMWuEapYuAipV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ejUidYq5hD3Q62EB7X9Y/49RTJNnIan8gSVJ1mbFOZvqQ1k7Nb+0Ma/VDkSz27Gkh7XT9q+VoOs9e10oQvmssdpRAllEE6DLR8yxePw1WwsqifLjrpeDDZWGY8k/kmXgTZwa5fxiV58JMtY8PG2ocYfZIFzigYvIKCLZ6QS28cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cL+PFNhG; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cL+PFNhG"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12776bebeb3so15859291c88.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644915; x=1775249715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgLz5FVqf/NV7m9qbKXaNWE4w/1GDJf1IUGYhV4ad8=;
        b=cL+PFNhGqLnw3Nx11U2NRKzy1sX9BqHn2atuj4oQVD76sAbpTmlhejNfUZGs/zFhvy
         WetMUao0I0s6yYA7UkDM07hIMBfdtegmeTiYLjX9AR37smM2624gYFHvHfiiKHfBOgp8
         Vb8QY7z7AKn5uy+AB+gwrcrXWMdjpqAL24p/MbwFPHAxUoUyATeC9bMTujciFfG3Qp20
         aT0oIKQbzz5xOtYM0+Nvl7XGCxDDuqMpeVzDLI7d0kyHCtHxHGRPGJdkDPnIEzayuWyo
         7eungRr5W2ZJbEUETlUhqdYBJuOXYgos0knadVP7c3BKdgERffkMy6IDASN35ldovo+t
         bFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644915; x=1775249715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgLz5FVqf/NV7m9qbKXaNWE4w/1GDJf1IUGYhV4ad8=;
        b=dCeDSlbH5fO8iM6+7gHzQFflzQ+gT4KYdfIeoH6h3RkfK4jX2GYWTfbaBo2TEhkOY2
         wXAZMFsrGUb1VhDB21PhY1Bt8/JB6iqS5u++iSDQ25JRBVJXLxQ/p987yBdhCgw7rc5U
         27KOQ0TZ8d0QXB+NtYcGru9B8bYhh63qQvs+QWMOMqM+rGvhuozLa2B1PRT+nWkBgMZF
         ivI+rkSY20l+auJhnWACUuznPyTIQ+4ivSk8MzRbSj4Ao6+A/bsG3x3T3LRBiNNi55UP
         s0AcLW4aRKpnjuP3sQarARnUFPRJ8aOneCSKs1sElagVfvfJ62e/1tpng1PnuR+gcD2w
         2QtA==
X-Forwarded-Encrypted: i=1; AJvYcCWLRQZqG4Hf13lfYaOMhgMuG7ZKgzIs5GE2YelbytvAxL9D6LHouE1fmxta/UA4yeTwuDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl17x/DRqGNDurWV+vl1+UY/YJHNhPpdTSbteVaNUEvmEpTn2h
	xaT3fsm37jGeWTMWovQIRa9knl0TyIK47X8ItuIpHg56rx53kx4UTXHvvC+8DAHWVoyciPra+mg
	UuEOlQQ==
X-Received: from dybml5.prod.google.com ([2002:a05:7301:1505:b0:2c1:5ad0:b659])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea30:b0:128:d7a7:5261
 with SMTP id a92af1059eb24-12ab28eba7bmr2796910c88.30.1774644914544; Fri, 27
 Mar 2026 13:55:14 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:57 -0700
In-Reply-To: <20260327205457.604224-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327205457.604224-7-surenb@google.com>
Subject: [PATCH v6 6/6] KVM: PPC: use vma_start_write_killable() in kvmppc_memslot_page_merge()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, ljs@kernel.org, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Replace vma_start_write() with vma_start_write_killable(), improving
reaction time to the kill signal.
Replace vma_start_write() in kvmppc_memslot_page_merge().

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 5fbb95d90e99..0a28b48a46b8 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -410,7 +410,10 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 			ret = H_STATE;
 			break;
 		}
-		vma_start_write(vma);
+		if (vma_start_write_killable(vma)) {
+			ret = H_STATE;
+			break;
+		}
 		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
 		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-- 
2.53.0.1018.g2bb0e51243-goog

