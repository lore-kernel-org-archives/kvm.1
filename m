Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604447;
	b=F+47CoE5imbinYJ+JYtthXN4zJar0etEQ8BOSXhFE1v0N1ND9TltfLQyqdODOgMzVR3Y
	 1BsGsFWq7MEmR8n/b7WtqpY4RT9A0iXKtNEnJbvx/avkhVi9ddP/rqnHBkU+gH3b+sw8O
	 GDVnjiWyKfL1RDqsLEI0NdgbHeD2eZLASWuvYmCJV1L90dKrIbLh3t2QhZsYuYyfvwcIj
	 ClFt64ts71m7v7Mc5ll2O02CXqVqdtouuS/LqvkfcP2WVSXPx1dOEZLQnKUw7UBWhTKiC
	 UgsFa+Jqy5O5JXO2HkBQh581Pmwco4IUotu6yKXOUP50mgEZ/RoQGOAk7bycRBwJY4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WH6OCX8O2rHrDc+AjcgOmeRyCyW9QUyc1yx5oWf9qtI=;
	b=b49i+OpVxkYpsg1sE2bUA6WBOsQJx+9uPHnI/qMDUhrYWB9/37Xcx0tnXxMXjlrRTCRz
	 9cdtpiHBNOAIC5VaRlw1O+tJoKX5K4a+8ZSxuHuxY3mXUdZmpYvGl6kywI/VuvLqROrJB
	 qXrMttenQZzC/3XNNNzrit2xcib0BHt78TBSIPCYHVll+u9kaVvcqrLzInr1wYTSeQIZB
	 P0Zc02vpo7YCQhQd94K2gZSm4jgsJ1pLFaUYRqquWGWO3mSHnL3RkaaIQxbPJ1SiacOtV
	 bOvx+0atdW0nbOyiw/1C9Pe/q4kTED/VVKnIYriEMXiqvwtXPzjRhewUwZ6xVPqbHrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dvt4iI9w;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F70606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6F70606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dvt4iI9w
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c5133831027so799097166b.2
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795604445; x=1796209245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WH6OCX8O2rHrDc+AjcgOmeRyCyW9QUyc1yx5oWf9qtI=;
        b=Dvt4iI9wNLShfT5z76hzWCPIE+O4afIQ/fRVNAxPKxirsD9s0p+EF6Z1V1SBO++C8R
         PAjE9O/danIxx3UAvz5FeTaQQxQgM0WrkGa3DxsE58n+LBuF55WXvHKtcgr8BKPU01mr
         CTsdnVQ4GbpqoMJzI0w2dDh0tMR9X9lSyv9hsXKs5HJyQucqn6pwU9CAOEurx3C7V0R1
         AaMvU0WmF0G95XaUNbYXlSxmGJy7gQdDs6y/pA4TI/FgAZgrhX5y9WFvZYeF+l60Dg9I
         kUUkW+6OLyLNBJtsHV4RwhrWm1BJi0TOEPwTjz11tLzUTdlNtIPIHCaZqpPtdjdz2Moz
         uLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604445; x=1796209245;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WH6OCX8O2rHrDc+AjcgOmeRyCyW9QUyc1yx5oWf9qtI=;
        b=Hj8+zK7kN4zZXwCA3cjMExDZiiDnKEj4NT4F8qtkC4TfTJT4MvgTo61Q0MFCd6Q1++
         AFOQXaDQaNBbF2V7JMFyZ0woZO+CUAL53HH7Yr6fItQfyEBF2B4DaE26QyfQ1acKdhUG
         2KMHMHwBD6ALZcINnn6L+lgWXRMKQWD2DN1UEg8qqW0D2fAjx4fKh27dA26tlxIj4XZU
         XOAOtsrcBGs9pJMXUq9mKXBVq6oBcf95rEzMnG+bg476Wo1tWgN4F5yOrZvGXTjvbiDI
         bqyx0XVjxv4uqSaYIY9X7E2dKKgoPEJk4C902wu4nzLN64lnO8ZOPhKYAN1kKN6+kgdW
         vnPg==
X-Forwarded-Encrypted: i=1; AL+hErE0O5qjcN/sfVk3f7UDB4mCf9qXvw0OCG7O/C1tCE8MdwDQe8eOWuLRBsMtxgyEb3dG2zM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KH/NQI4Xcckpar7fPTnUxD3slOsYpQqnvMih9SN747Hw7tCLE
	efCQEwpmM6mRVIaEUZ0+6QwI0613ak3RP/ePRbQvvs/aM/kpDJ+2FCtb
X-Gm-Gg: AZFdTZdUN7twOVAhB1aKYy8jlPDYxzmaEUNWoqtMwq0GxUlexQIHX8r3F6fkrlXP16T
	lm4QkqSW/yWEj0iis6OAWHOjsKsvye1Ueusu1o+5d59qbUtZr0+yTp3zs+4MOMdgO9/vWF/RzdJ
	rDJf33CwcF1u9q1S79gUu1BBFc97H9zieP6pMNe8mmu324p3TG3+ziMPVHxjK96T4sL54fcHnhF
	0BLfwKwxYU1ZmkyOCWU+JKiOtGKkaQx2BJNl/FD8WI6aciI+cS+F3npv5Cq6gSVp75xG6oIFDpc
	meIlbWPL302v4hHSJB5kzKuKElirfEyPjt6Uq8757Kg1Jj/xMyWdWXLK6VbkWJTZxRGdme7O0Wd
	94mF+C/HIF7HZgAnUDiMcOdQEqKkj/VQaX9jK4owCgcqHzuA9VQ4salJHy5lS5hZbDGiDl9ldFq
	9li0KhwZkp8z18cf+WEQ/7Hy81N4ERuHMLh2bqB4VTfj1foAXWJVfz682apUkpjJA5DKMHcPLKL
	bawSNqg41hwC9F0zfDiSkQdC6+odMyfClKAftAzkJKtO1bEVhXJnxiMpaAPes6E5aAd4BZ53+4u
	JT4yf/6WXkpCpqv7nBRrYI4/5sK5ZsIdsGJz
X-Received: by 2002:a17:907:6eaa:b0:c46:d837:b358 with SMTP id a640c23a62f3a-c513a4355afmr1482828466b.3.1795604445261;
        Wed, 25 Nov 2026 03:00:45 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe01a0sm626673666b.68.2026.11.25.03.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:00:44 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <3739cc8a-04a6-4d17-96f0-db70833c700a@xen.org>
Date: Wed, 25 Nov 2026 11:00:43 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/21] i386/xen: Free Xen vCPU timers when a vCPU is
 destroyed
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-4-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> kvm_xen_init_vcpu() allocates the per-vCPU timers with the CPUState as
> callback opaque, and nothing freed them on vCPU destruction. So a guest
> could arm the periodic timer for a vCPU (VCPUOP_set_periodic_timer
> always reaches QEMU; the kernel doesn't handle it) and eject that vCPU
> via ACPI hotplug, leaving the armed timer pointing at a freed X86CPU.
> 
> Free both timers in kvm_xen_destroy_vcpu(), called from
> kvm_arch_destroy_vcpu(). That runs under the BQL, as do the timer
> callbacks, so it cannot race an in-flight callback. It *can* race a
> timer hypercall from another vCPU — hypercalls don't take the BQL,
> which is why xen_timers_lock exists — so clear the pointers under that
> lock and have the periodic timer paths return -ENOENT when the timer is
> gone, as for a nonexistent vCPU. The singleshot ops act only on the
> calling vCPU, so cannot race its destruction.
> 
> Also move the timer_del() in do_set_periodic_timer() inside the lock,
> where it should have been all along.
> 
> Fixes: CVE-2026-123069
> Fixes: b746a779264f ("i386/xen: handle PV timer hypercalls")
> Reported-by: MyeonghunPak <https://gitlab.com/mhun512>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4098
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   target/i386/kvm/kvm.c     |  6 ++++++
>   target/i386/kvm/xen-emu.c | 36 ++++++++++++++++++++++++++++++++++--
>   target/i386/kvm/xen-emu.h |  1 +
>   3 files changed, 41 insertions(+), 2 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>
