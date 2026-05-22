Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3815D26E6E1
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490959; cv=pass; b=CKEGb8j1ZxWKqiQssXp8pDpRlzMw4fExgjU864SWaCMjFBhTkN/L2WRak2XYO37NEfU7iDm8Mp1Qo9mf2P9KvJEZjQusd/vxP2BBzwEJMpWBOLCMiEAzGS68mgNdMeShjez/l+xho2lXqTU5Tle+BlYQyqW4jZqRqOWjATNCosQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490959; c=relaxed/simple;
	bh=ibZMSZEwhsHjGnLBrHCL/QtGJncXCz0nJYgEJjvO8KA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/lpp1mwRuh8VIlsagYI64QC7Nu37gzWTqgKEcYlJ+lEZ3qQdPGegID3yTO7mIJvCPwt3iH9w0CubxrpuR99b1eYpwlCJ0nB6poc/o55xPElmMdi/jDB5rOtqHR7CKoefklwqDxmuoitRtCNznmakNIi6yo+TtcJcglx2+MR6OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7RAAuaM; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7RAAuaM"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-57513a91514so2633461e0c.2
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779490957; cv=none;
        d=google.com; s=arc-20240605;
        b=cTQBvTiloWC1077pfjTCJFlsPDbtPDfjJapJtYwqtnqlReusd0TmVNEzPRFOzf5F0G
         ADRKbMMa6062LJznioajHuVL73KAaffNLNMKjmFZE/Rwr+w9YcN8nXbO01RQa6Vg1M4S
         gx8YA8kzpyN5GOeVmsNxiUR0egL70Opp6QA5ZXGIGrI12ctENdjz0aeg16PUUw/Rc2ZR
         1hCbOZGJyj8dmfkX3UGQt5v7a89QmffCRH2pIIS8vPn6W6pt1VQ66k13xLqCQkQtLaPb
         bqGCdYa3i+GKODnuOVKHUnopECjMjzCY5NTSg3dzuOiPR0K+PjWVbyZCETxE3QAdRMAW
         l0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+lqWW5xTN76UwAfrRbxGlO2NBxcf8RIbZZTDif3+3JY=;
        fh=K2s5paTATC47mmzoLaxt/PMGMtJ1VAH9AppzvIVWXr4=;
        b=dkq8CZ2LTGg6rewobwHJftQYdjyMuVeLnazArEprsf/xtiFrN2MqpPGWGfvIcL2ESZ
         aqvyDw6kEmedB4CIOsDvpco6/c4wNNx0IFsAEdEyiA+IQNRKQVL9l24n1DjxokjR14e8
         eAixIyPo8XDKUVpoBrf5SQoYSikhG5xytuVr1qDCpiUIxHiMwpzAuaGDzIgSUsZDJ/R/
         3/jmRZSfkmDCifKj8CM88V7Iwnk4ZerNWmFPsdCQ/mXqcRK9MFj6M9wH0vQrq21LXQg9
         RE630JLh0kWlbOCzS78TDJfH4em2AUqf6fygL7XQEK3EhJpU02xx59rnB15ogPUi6vbK
         XJQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779490957; x=1780095757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lqWW5xTN76UwAfrRbxGlO2NBxcf8RIbZZTDif3+3JY=;
        b=V7RAAuaMj0XsToe3ledva7W5zL38tTCRlQySm9U+TS+5i0dNMKqC2HDC9cyNZCgjrV
         Gkz4eD8wMdrLmdkQLGy21ZSl1GcsmRELOpoznKfDnyrzAy4wfv9mCc+RDCkNOdMI1BG4
         uZtAqTPU5XTedQoS6MMZRDcweXidvstgjRc44x91Ry4HAOzAoOvfG6ixztDDgV6j5J3P
         VlYbWSTwqx/LK2wX1lrVarPLc8T2EM3gDp3PwME9SFoGaeZGgq1IrX3HLGsT8xfNKmuw
         R2Zi2th++hUxa4E9zh8Xc+zrlb2Ca871O68HCInBo0+mGnahxdxGUrvClhbT50X1ypV0
         WwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779490957; x=1780095757;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lqWW5xTN76UwAfrRbxGlO2NBxcf8RIbZZTDif3+3JY=;
        b=dLyvTqLLTtw7vIErE5u/CYmPk4tDx+9T8hUPoF53d1DppzOT4gMavne/Di4d6n17pw
         Z5hu6cFsEnI+64GeYaLGFqwq1mtvXu+Jrf29090rRwIb8Qv2fuDm+Vs4cVZzMKsXJXEK
         eAiX2gqTXugoAwNJeR3t50nx9VkLOd6WHuHDZiFxvPCyBBwscO6PXgG1qrGq7ZajfJUR
         swg890nK3gQPECEz6JX3yFn40gmmQhGCpoDcpZY+n+UuYgbnkqzLpV22TOuEizBZXocq
         QYuS7pr+2bH7pQJ1Uw3TF2gM75+mByz/5nfZcUoq6lqCdPmUXvjlVjIoUc7ObIW55nVZ
         FDoA==
X-Gm-Message-State: AOJu0Yz1nrWejVyTeWtLQ9N/303YwxynYkphdmaDMadhJ2Vo+Un2oGFC
	vsIxeITFDRKbCrtcAD1m8Bde9rFKkasBDWWejIdOaItY3Cn+ZdbHJVfWuWtsm4S3vpjvzWRqo/h
	/rerp3llM6YClDTmy7524MzoVdIQDJ0fWwyBZVYfe
X-Gm-Gg: Acq92OEww3wqHVnaYGlq585/Og6VnWs20XOIJnbZK7h0TaT3uPlsZGYBAkoxzJ2+FYH
	o44QXXf7QBlrqPcatisCYRrWX7QiyUcJqtsyfMYooVgiX+YCNT5/vyvrOFDmMmH9Frac1KXXLGb
	WlhunNH1SJxCdscW38ikiFllizQ5kq6pqeO7QTz4MwJ3RDsYFVzKixBhSKcfT6L/86bmHYtV9VD
	nyHdbF1CIolFl1aUyeG+3Cli4D6QVE11BSMP+hqKy/D5/PKaAKhPgO9K+1rrEVXLtDoLPSnTBf1
	f4fTvbAyoruKb5H/zPjYmyXDQNilK7AuaOrIZlmXOCRpPD0pLuWkLdtleEd0JffEWhX25I+VmFD
	Grvf8
X-Received: by 2002:a05:6122:1796:b0:56c:db8b:504e with SMTP id
 71dfb90a1353d-58663966692mr3461861e0c.13.1779490953839; Fri, 22 May 2026
 16:02:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 16:02:33 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 16:02:33 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-25-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-25-91ab5a8b19a4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 May 2026 16:02:33 -0700
X-Gm-Features: AVHnY4KLpjLWXQlawB-gZxOwicuZUmspmndJ5b1mQf8zRUUhG2Ao-NrVmxpOgcg
Message-ID: <CAEvNRgEHf67kpLtNyET7cvE5hWfXHqNrwv9cP9bRUgk_NKb+0A@mail.gmail.com>
Subject: Re: [PATCH v6 25/43] KVM: selftests: Add support for mmap() on
 guest_memfd in core library
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

>
> [...snip...]
>
> @@ -1078,13 +1077,17 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  	}
>
>  	region->fd = -1;
> -	if (backing_src_is_shared(src_type))
> +	if (flags & KVM_MEM_GUEST_MEMFD && gmem_flags & GUEST_MEMFD_FLAG_MMAP) {
> +		region->fd = kvm_dup(gmem_fd);
> +		mmap_offset = gmem_offset;
> +	} else if (backing_src_is_shared(src_type)) {
>  		region->fd = kvm_memfd_alloc(region->mmap_size,
>  					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
> +	}
>
> -	region->mmap_start = kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
> -				      vm_mem_backing_src_alias(src_type)->flag,
> -				      region->fd);
> +	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
> +					vm_mem_backing_src_alias(src_type)->flag,
> +					region->fd, mmap_offset);

Sashiko pointed out these:

1. When mmap() is done for region->mmap_alias, it doesn't use
   mmap_offset. I'll fix that in the next revision.

2. mmap() may map past the end of the guest_memfd if, due to alignment,
   the mmap_size is increased. That is true, but I feel that that fix
   should go with a bigger clean up for vm_mem_add().

3. vm_mem_backing_src_alias(src_type)->flag may contain incompatible
   mmap flags. This is true. For now, when guest_memfd is used with
   vm_mem_add, the src_type passed has to be VM_MEM_SRC_SHMEM. I think
   this also falls in the category of doing a bigger clean up for
   vm_mem_add().

>
> [...snip...]
>
