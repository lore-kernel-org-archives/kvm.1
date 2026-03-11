Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA242E9EC7
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773200240; cv=none; b=KQQaU6Pw4BOdiBlYm/ADGPWDgyXYB45fpNEGvA/I06ZWKUhmRh4+a/dLNkliI1NeZ/yWXS+I9ItNeYEnoZD4YIe/6CBHN0EOELJAYbn0GLKSDcWEz83Zy/61krLDgOSWDAwMsjpzZvBK0JdaTF+95R2k/0JhdsvzyXCh5WmYGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773200240; c=relaxed/simple;
	bh=zgxGKH5m6Tqc+M2Ej4t1TWZbYs9Cu9E2CfQWxq6i7wE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=r9NC0jwek89Mi3o0wnSmj5d5D2VAqqLjpgXHLAkDqn1cACk4Oe4sziHFY2AtXxvMYrlW6WssGPZtLJSud12+CzYP4iAEIq4BCB6ACwxoiixuWxbKUF4G6LR54yU4u5ZBk9VERWqvxsjt+xfOag0IjPBtJ4zhH3UQfjyEF3Nd5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMAvsXHB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMAvsXHB"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8296d553142so3512342b3a.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 20:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773200238; x=1773805038; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rHxXiAvo6zOonxHyAewJkbWbuOENn2paNkRQUdILloA=;
        b=SMAvsXHBvxwFHHwI4tLG4izeFsA2TISpVhK5zuPBSUSRUHZvxu2qgg2kBv+je/TcPD
         7NCvQ1dmdpYlnOULfNKSToR0XZH0emrp7MMG2DxipHN82Oe7qd/sPyNftdyZbZ784x08
         aeWx/LaAQkwbufvpmZnZZpehm5RzJzr/Sqpg3WyP72pZAK+0nevvZ7pNBH5kzVurK+Yf
         STYqd9vmUBgKr7LlGm0ZeDsGhPP1yLTpEAufgnMns/BVLEv+57N20vUAGhBXVKIs3bIV
         5up0xW0tF0dFMQsrqdMMmoLpZsILNJLeJLB8p4NgkEaXTwhjfeZHDB519QsNhVB6lJjO
         mxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773200238; x=1773805038;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHxXiAvo6zOonxHyAewJkbWbuOENn2paNkRQUdILloA=;
        b=S9kXlcqH6HlXCMoBfcp6t6B069cWI6mlrWJfZ/6po0QIugYpEWhmrww8+TM6GGIuvn
         eoXwZHCntXp8TFZIRKRM3/JTXIcPpvDFY3XzyTSTQhP6g87goDO1+5wRkSgH93C4XYck
         PsmODIT3YCdcJt2tNSLS8kDXlL1xYHDrhhZxZ7NEEB/dDJFEOeIrBZ3mhRV6xMbJ4IzH
         lYz9Q/tZovMGTAivtP1e5FezWE79mFrT04ddKMxWVpZrcR+QUXZi9LnIcMNWZsJkznSV
         qr4S2cgE0u7cR9H3A/ZwYhojFZOxbzHhDBwC/kciNqgzSfVo3LBQYqVki3j+7OSmgcnY
         B+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaDSHhHiBY1uRhRgor+fU4A7vnuWLpAVn/4MCriOXXnSvlg4I2ZnPIzQKWrJzsAobcrhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNWH8p7fc2uObLdLan4B0trqBgdFu4vILIfr8uiTCYuPLap7d
	xWUUqz+Ojl88SAIDX4Ek7kkOcZgDbIyuPZ/TDZhhDSuQn2hraEhz3dvXI4+GuB7R
X-Gm-Gg: ATEYQzyJZpIge1nqkFRXGPL7yYn4ewhMT4fJ21UNyKVEJMibmB5odReoeWOe02yt2RZ
	7i68hV3d03dTMEvFlNHAV7Yv7blqX90qYxo3mvrt4Mys9hufoD8aONQEK/yQLtJr97zyatCAL/c
	x2zmRr+Tf8ml66z814QydzX8SFGdDKeTQWQL54KqFVzdVopJ81m19WAQv0985lJ15kkdFMgdkoa
	8afmdZ6AABEGThUsRMfX8pa+/Hf4rG1RkGMWsSTy/pcOll+zaHCoMd4IfSna9cs4eS0J73wY0dE
	lfAEGNNrqW847383dJFAeKD2pDYFr/5TV7++FWBXljY6fQQbVV8Lh2ZN1Co5qsKcNyg1YMDm54B
	+OGNT8e15UZD3KaqW6vOwkt+IcMBp6oqC/WE5uoWmpjawZV190H4IDi0Qr+CpCOzg1AdXUDU3Yc
	OI9B/oEuAGh+cLX0uJUUCErh9LY1yyrj7u
X-Received: by 2002:a05:6a00:bc93:b0:829:7d88:34c4 with SMTP id d2e1a72fcca58-829f7274b2dmr1088865b3a.64.1773200238028;
        Tue, 10 Mar 2026 20:37:18 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df3bcbsm752506b3a.15.2026.03.10.20.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 20:37:17 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 4/4] KVM: PPC: remove hugetlb.h inclusion
In-Reply-To: <20260309151901.123947-5-david@kernel.org>
Date: Wed, 11 Mar 2026 09:06:06 +0530
Message-ID: <y0jzt4ux.ritesh.list@gmail.com>
References: <20260309151901.123947-1-david@kernel.org> <20260309151901.123947-5-david@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> hugetlb.h is no longer required now that we moved vma_kernel_pagesize()
> to mm.h.
>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 1 -

Make sense to me. Please feel free to add:

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>


>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 08e5816fdd61..61dbeea317f3 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -36,7 +36,6 @@
>  #include <linux/gfp.h>
>  #include <linux/vmalloc.h>
>  #include <linux/highmem.h>
> -#include <linux/hugetlb.h>
>  #include <linux/kvm_irqfd.h>
>  #include <linux/irqbypass.h>
>  #include <linux/module.h>
> -- 
> 2.43.0
