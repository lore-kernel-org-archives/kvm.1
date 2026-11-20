Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192869;
	b=lhRzoleUcldZ6BNXqAuW+1tEtRyi5ZFAvPcGWxz4UqJ6Bku7c3wDUffaENgMyY1cFNVf
	 jTv7dd37u7I87OOxnc7Nguyorn11sIgqaPItxPmitjsqmWqt1JZoffjQt2d5pvkw8BHW0
	 73Z1YgcSyPZ9ff8zhy5nRGI7F00/hAmAbd0FcgHC4lWyZEipjIes3v7EJkJ4tM3zVW+dB
	 U3FwbX1dOMEtk9X8Koi5gXDNKdn59RsHI5UlDNC9+UbuAJPmpm2F99nFEJ4UoD0luwckW
	 zJSUESFJmLF0D8WYc3ue5+k/cQrGZSH+MJzZyZR9Nc7UpKWfIv0QPJlWMCKtPUaFcfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192869;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AXJ73gZbDqFdLSj+f85ZsrSo29IjJTKtoRF5M4E2k9s=;
	b=UGk6NTDt/u4IuUCsRYdWbr5l1SrfQ5le8fHw4h5zwROzLWh1W7gOt+iso09uLGugEZNn
	 kYBCbWvMWVIa4slQyOA3MEjgGtBYBL1HFPVOkrR7uOClaIRmQuE/iKb75SL94qYDGpH3Q
	 XU7Qgibzh8VWMmYV4+78wlmaiK+xB0n90ZqbLSKt1vdiLsQWpYhk2A44okP+O/61xX97h
	 5HIjPfR0l5WGsg+9FxxhOHBp/ElDjpTXc1EY8i1uhxo63AEf2lvja0AB/+IkdMCq1djzm
	 0a013lI8pGN2VaA/AeykAMDooE0SbRnh0NSVPtXri/3Rmpent/eRp9b22TtoTCWxZ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="bJNgXs/n";
	arc=none smtp.remote-ip=91.218.175.230
Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2A60A2617
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 16:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A2A60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bJNgXs/n
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZoM2yf3MA8k5sZbw96Hh1V2kwRR1l1ZCz3uIHytu5jY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795192864; v=1; x=1795797664;
 b=bJNgXs/n1QT3IoJuJIbKvzdSmhhdwzylK2Sj7kxe2/0hHFFfJyWva9lJHMhWlt1dxYYqWpz4
 IB+fG3eztkt5lXlMnmK3H7g9/dIsemLKV5O99g6qXR6goFI5VLkjhu2I28PIbtErTczMU5ui1eo
 5rkqrgpOrrDhDpzG5McbIsbI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 883b19b9dfbc7c0f;
	Fri, 20 Nov 2026 16:41:04 +0000
X-Mizu-Trace-ID: 883b19b9dfbc7c0f
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 17:40:29 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Koichiro Den <den@valinux.co.jp>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Bingyu Xian <shanbeeyoo@gmail.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] RISC-V: KVM: Batch user accesses when updating steal
 time
Message-ID: <awB1hZGh3LYztjqL@orel>
References: <20261118062242.2914385-1-den@valinux.co.jp>
 <20261118062242.2914385-2-den@valinux.co.jp>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118062242.2914385-2-den@valinux.co.jp>

On Wed, Nov 18, 2026 at 03:22:41PM +0900, Koichiro Den wrote:
> Updating the SBI STA shared structure performs 2x get_user() + 3x
> put_user() calls, each of which toggles sstatus.SUM.
> 
> Keep SUM enabled across all five accesses to the shared structure.
> 
> Note that write barriers are added to order the odd sequence store
> before the steal-time update and the even sequence store after it.

The barrier additions should probably be posted separately with a Fixes
tag.

> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> To reviewers: please let me know if you'd prefer
> scoped_user_rw_access() here.
> 
>  arch/riscv/kvm/vcpu_sbi_sta.c | 59 ++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
> index 60e50296a008..cfc6f22c3e33 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -8,13 +8,14 @@
>  #include <linux/kvm_host.h>
>  #include <linux/mm.h>
>  #include <linux/sizes.h>
> +#include <linux/uaccess.h>
>  
> +#include <asm/barrier.h>
>  #include <asm/bug.h>
>  #include <asm/current.h>
>  #include <asm/kvm_vcpu_sbi.h>
>  #include <asm/page.h>
>  #include <asm/sbi.h>
> -#include <asm/uaccess.h>
>  
>  static void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
>  {
> @@ -26,13 +27,13 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
>  {
>  	gpa_t shmem = vcpu->arch.sta.shmem;
>  	u64 last_steal = vcpu->arch.sta.last_steal;
> -	__le32 __user *sequence_ptr;
> -	__le64 __user *steal_ptr;
> +	struct sbi_sta_struct __user *st;
>  	__le32 sequence_le;
>  	__le64 steal_le;
>  	u32 sequence;
>  	u64 steal;
>  	unsigned long hva;
> +	bool dirty = false, success = false;
>  	gfn_t gfn;
>  
>  	if (shmem == INVALID_GPA)
> @@ -51,31 +52,39 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
>  		return;
>  	}
>  
> -	sequence_ptr = (__le32 __user *)(hva + offset_in_page(shmem) +
> -			       offsetof(struct sbi_sta_struct, sequence));
> -	steal_ptr = (__le64 __user *)(hva + offset_in_page(shmem) +
> -			    offsetof(struct sbi_sta_struct, steal));
> -
> -	if (WARN_ON(get_user(sequence_le, sequence_ptr)))
> -		return;
> -
> -	sequence = le32_to_cpu(sequence_le);
> -	sequence += 1;
> -
> -	if (WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr)))
> +	st = (struct sbi_sta_struct __user *)(hva + offset_in_page(shmem));
> +	might_fault();

We're probably safe to drop this might_fault(). But either way it's fine.

> +	if (WARN_ON(!user_access_begin(st, sizeof(*st))))
>  		return;
>  
> -	if (!WARN_ON(get_user(steal_le, steal_ptr))) {
> -		steal = le64_to_cpu(steal_le);
> -		vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
> -		steal += vcpu->arch.sta.last_steal - last_steal;
> -		WARN_ON(put_user(cpu_to_le64(steal), steal_ptr));
> -	}
> -
> +	unsafe_get_user(sequence_le, &st->sequence, fault);
> +	sequence = le32_to_cpu(sequence_le) + 1;
> +	unsafe_put_user(cpu_to_le32(sequence), &st->sequence, fault);
> +	dirty = true;
> +
> +	/* Publish the odd sequence before updating stolen time. */
> +	smp_wmb();
> +	unsafe_get_user(steal_le, &st->steal, update_sequence);
> +	steal = le64_to_cpu(steal_le);
> +	vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
> +	steal += vcpu->arch.sta.last_steal - last_steal;
> +	unsafe_put_user(cpu_to_le64(steal), &st->steal, update_sequence);
> +	success = true;
> +
> +update_sequence:
> +	/* Publish stolen time before completing the update. */
> +	smp_wmb();
>  	sequence += 1;
> -	WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr));
> -
> -	kvm_vcpu_mark_page_dirty(vcpu, gfn);
> +	unsafe_put_user(cpu_to_le32(sequence), &st->sequence, fault);
> +	goto out;
> +
> +fault:
> +	success = false;
> +out:
> +	user_access_end();
> +	WARN_ON(!success);
> +	if (dirty)
> +		kvm_vcpu_mark_page_dirty(vcpu, gfn);
>  }
>  
>  static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
> -- 
> 2.54.0
>

Otherwise,

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
