Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEB38D6A9
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486356; cv=pass; b=ZWGgd8upZHBflrbeRw8wUOROP2objc9g75aO+W0Xmwl50edOXLBeeCycagUPp+dKRkKIFSCflQkqj+FnNnnpkULRml9yo/HmZNII2oLrXAJev8U/iPYWRGQ2OndaWwTN3zlGw2sYxI8D7ZmIkyZyCNnuIzLN4tHQWoKKmO4oCZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486356; c=relaxed/simple;
	bh=yeXSyELI1E2yiYIHqqHrMC7NqZzRTFrVfjXKk8f/rzo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdO8jON4ieH9LTi4gofcj5mrWwdZ/HUPfZFKdc+9E/8FsXzdiu6OCQWL7JDJ7RTKm/J5GeUcMOWzNwb3HaRBea/uWyD/ZIBcb5xrUdjHAvtXbxplNaPoX3vNw7iNyP46ckdmHKoAWEmqGAfE2liNuCM9U35i/1mBZ7QjwrvC2tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrAiuOtq; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrAiuOtq"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-632a055fa9fso2915900137.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 14:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779486353; cv=none;
        d=google.com; s=arc-20240605;
        b=kakGesr4Uzk+1txuukhoW99KjqvZ8vm1QY/1d/ScA8AVpGoDyswZZScQe4aYuVoDgE
         bNUraHGAkQsoge7Vi0noCZ5Z2gpXwoQLmg10EASLheCLAMpOvPUcdSmBsIHE2Z469AVC
         3+tDevlnPxnVVs4qzwtf7+Qf8XuTSGwpxJO3JFMnltSUYYkyo3YRX4jotDfBSIkkVUA8
         +fIEr2Qs+qQdTVBcpqh3YZOPMZvYfBfI/LjLW2oKjt+wXk49I8TQILwqliOH3atZurZu
         W07CHLbWrV+C5UZ26TYtL9CCq0gs7vggjuJlYI4b4b6Kx2C/+T2wNlXmAF3YomyicNXf
         cbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=HF/NjXSXWmsZ2MTdon58/xGzT4WCBzILiqAAQFlOD1k=;
        fh=K2s5paTATC47mmzoLaxt/PMGMtJ1VAH9AppzvIVWXr4=;
        b=BcDIsJHdvkJlYitOYdVswDJN5IWuLXijuR6umed/ljVapceOx8k1WRdaJOq12Ab/hv
         qIPlKGuUPg3FxKEfIIxNI6nHLez7HyrBiYg4b+CQCW8ch6vWvLw0G89wM5TRPdG2oAx+
         BeUn+ulclQd0Ncwaf7nDTTxRL+8E+GdN7QnYRQwY4l0dSUpvDXowRZz724mC+q8Nxs35
         VbTbYkYgShqKnelBsJzHFBUwXvp+nJoTN0LPesv5iMgyeMxrtivEgvZ+nE8k6cmtMIA2
         7SM+XYbY48gHwJ/pFrN/5dX89APE5gbc8+hgfqdOeuLEzW6zXP4rApXUrXvzmoOqwR8t
         JdcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779486353; x=1780091153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HF/NjXSXWmsZ2MTdon58/xGzT4WCBzILiqAAQFlOD1k=;
        b=RrAiuOtqBcUqVZiRfph8W6B1cp6RwD4bLszq0B+KL/5CDkhs50X+q+b6/IeuOhYEi0
         7A1cexEvgfOT4NE5bpUHLqTUdnacaFMctWqkINpMx72OlqZQedIFbRT6XffoRYH35ORn
         8drIzuNRFAI1vZVgobXbhY23GshQb4c3HK2zKv+I7jU/T2uLUNIidUzxSyIebSytyGOV
         K0qfncmYSEfdypSK51lpTKuYNMowqTbl9eSqfx0pjru0Zj/f8mQXZXHRxh7KUsz2EtbA
         G6PHgaOYLzbWIFXIye4VlF55w4qXCUsC3kED7AfpnrfpEMT4fgDu9lb8UsJvKiJka29N
         gybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779486353; x=1780091153;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HF/NjXSXWmsZ2MTdon58/xGzT4WCBzILiqAAQFlOD1k=;
        b=kZXE2eTF9Pm0agjdq1kUbB9xZ2MdbpBZcleiK6GnyyPIvqhXXS5j3VZKhraTp3RDlu
         rRdtdpikdP50DUa1kquoEaB0wZGPqAN5D7D+6nEPIuoPJZVejAcWVAtoP3TJitkqPfJn
         OROwIYMW2SmEGLnJdnM4Cult4CowQhZVNVNFXlJRj30NnZazdt5bWmjab2amVEFbXaSj
         YGlVswR3WhP2wblMecd6rfHgXBddd9WAtNq7XpxRqmrzQePQ5Q7fCwS+clp8MmIH32ao
         OMPt4X8c2fUlGjfn8CewnZ9zKQInQpymbIXwymbpMWWeMzXmG1zfvWK984Zj/LUx+EL8
         GGnw==
X-Gm-Message-State: AOJu0Ywb81XSFc/r8OpiyNu/ptJzqM2/91dPtuifMUqU4J4BZCiZgRDv
	gYiZPhddZV4RC8dUC8AgtZbFOW/owF0dC+P3z9hEWVYEzTCoqOhZ7AnfSCo6Sos7Kur23Y4Hsp+
	DyzV6Mkd0z/AbQIib8NlsQkZFT8g4i8r1ns2lc+75
X-Gm-Gg: Acq92OEqBz7oIWaewYkyvitqulb+F4YtM53wDf8X//274eCQEdQqAWB1Piysit9X+tz
	tId6kCAuttZKxgi8mU8Oq6yqUNDydgkXTULzF+MDhHdPSzYTZRSkKf001BUFAWNX6c8FmUzh5Z+
	NsCncXxpFrBoZOfddMud9RuHRMhO0qWEpisRxv5lzdATrs+6tmZBL1GXVete2RTCBrNsUQFUNwp
	id6dnqM21S1kPwJIvqrYkcG+CWDULxcDwJr4Zs3oSUkAaDzBMaJhLP0qE/Xcg36NL1I+4FAb5nL
	69mg29I+CIaYHpHUq5ifoyTSVCYK2IQ/apaVzJT/5rTwOyyHqAskItCJNclkOqUBohdIMKt0jS8
	BtvPq
X-Received: by 2002:a05:6102:3e28:b0:62d:b0b2:88b1 with SMTP id
 ada2fe7eead31-67c7405ef67mr3506832137.4.1779486353069; Fri, 22 May 2026
 14:45:53 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 14:45:52 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 14:45:52 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-1-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-1-91ab5a8b19a4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 May 2026 14:45:52 -0700
X-Gm-Features: AVHnY4JHUcmHMeS0I0OECBQE9WDOiwFNaDvy5ucV_o_GqQwFVlnoZJcBRTb3Ibk
Message-ID: <CAEvNRgEjogBVDRNs2KmA--u9vHY1Jex-ERUuvK5idUrfoUBmmQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/43] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
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
> +static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
> +{
>
> [...snip...]
>
> +	filemap_invalidate_lock(inode->i_mapping);
> +	r = mas_store_gfp(&mas, xa_mk_value(attrs), GFP_KERNEL);

Sashiko says using GFP_KERNEL with this attributes maple_tree could
allow a process creating a very fragmented maple tree to consume lots of
memory not charged to some memcg and proposed using GFP_KERNEL_ACCOUNT.

The problem with using GFP_KERNEL_ACCOUNT is that the maple tree nodes
are allocated from a shared kmem_cache maple_node_cache. Allocating the
maple tree nodes using GFP_KERNEL_ACCOUNT would mean that the node could
be reused by other maple trees unrelated to this process, and so the
nodes might long outlive the process using this guest_memfd, keeping the
memcg alive far longer than the VM.

For now I think it's okay to stick with GFP_KERNEL? Does anyone else
have suggestions on how to solve this?

> +	filemap_invalidate_unlock(inode->i_mapping);
> +
> +	return r;
> +}
>
> [...snip...]
>
