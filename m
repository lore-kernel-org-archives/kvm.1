Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794569489;
	b=GvNZ8u/oV6b5WAqUoGVU1Wh6Hd7PAeEwxsslE5tDtkKDGg1HRLevXZI7bq6NzSru3SD7
	 cZAmrMn10pQGcOL7+eXWv/sCHsRVHRcsCXFGWonan/h0EbiyeZMI8/Xu2wkTw9Lcw/T3V
	 Q4GFd6r9zJIEj8L6D9+ELb/D4/bCdeQ12qqQs59iZk8uX+6E/BLdFiTlw2a63BsqvzYyR
	 8XbUjamMf8FUb1hvvKYJQLMF3SwsulzTQip+R/BMjIPwCcvPDhvDfOM0E2gG4nQFAMjol
	 UIQOsT1rg/AVK422K7axZzTAgs/p+RgAfAIJNRrgnCGI8mXIoOFJhLohSK2Up80sWtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MW//+eO8ifeDOMCGO0P1S62YlRWi+XpqU3MxHUVvu60=;
	b=5Q4qKBAPOS03tPzTg25Hz6K1/eRfcBp3Xja3la4/x0HIco/MkK79lrfpBcKevuyKcAqK
	 saj/OUs48HLUTEEECSLIYoZ2uq/S6q0sqEQmXiTRtBtKj8D9fGE8qaQRBScqNXICahLHN
	 atEuPUKpzpIU1jk9Dia8fEOBM8hirumaWPQO0kZhTQaNKapCMEBqzBkMDyXmooddJXS/u
	 Ktcz7P+kr8yy8URegeOONxdWra2kfrXzjU2f2V5BwRMhxhD/GbYC8mzMNUqEpe6sgINWz
	 LIwnKZy5+x6haknvgOX/2WiLHKnWnIedUWwkO7+3DK+2QrrFgTTXeadbwYZuTlj65eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=eZzmiXS1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA1606A31C
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 11:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10BA1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=eZzmiXS1
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so9051215e9.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 03:31:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794569487; cv=none;
        d=google.com; s=arc-20260327;
        b=RN61wnO9YmZXVxq7dodRQJ/TJQ6Qj/QyWrLAe3YGBf+Symxk1rXNMDKEUFkoXsNydD
         qeCl1Aqxarqz1x+hNm+zq4Fo03UsSjd9o0+9mcM6cs/fjuHzqyydvSm7jhpjfz4dvwS0
         IJchkv9iynldWA0ghJq3jNTbr4SHsj5GiMPI0G6XArT5QHuLdt1E4kEhhWUi/Zm5He1l
         vzge7iSq09xKY/Vl2cdNMaIrSFN9ShTeat7X7NJPpZiIseUJ/ztcJh4hPbx9vyK8RV6+
         R9tlfiYRda/N5rEZSAorb1e/mIl/BWrmXtm4Z8935bNh7+Yu2l3C7c11SyXYVsmVU6XN
         3EOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MW//+eO8ifeDOMCGO0P1S62YlRWi+XpqU3MxHUVvu60=;
        fh=q0YbRpAj4f68ZoEnk0/DPy/XUF6EjuOkwNmwFdqPirw=;
        b=az+EWpL9MEgMA8oC6iMYi04Wlgp2JFSEZElXCZRgetnsxNBOQQI2veZFWaytFJpdZS
         E0BYhQ70gmxUnOVGFtbPhZzdFvBTaFc8lRmOLzLt0kv55G4jXwNMnCzcO7LxymSFG4yy
         sQsZK/5xVUVeTItiiwsztZ+NnVg64nl12jc22+uf/CBRZs/0HN5mdjrwQH+wbWpXmw+Z
         0RwH1Y9KxIJCHjh+fuoDSEhJFeKYFLtrKR4fHXEXF4P0oEuuv93lnm0z4Ig9npUXBENK
         bVWl5nZdfUXgfC67QgWPrCRuXXlIfCf4m/IYOwvYOD5XIBaB4bXNxMjgs4XkcZxImqZf
         YGwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794569487; x=1795174287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MW//+eO8ifeDOMCGO0P1S62YlRWi+XpqU3MxHUVvu60=;
        b=eZzmiXS1W7ertC3npfms2hQkBYqVgQr/LcUUlflv3tneq8J0mJ5P444hFb6/978208
         TbXAYPI9LkJPCQDpp/vCAYyIP1zaiHEDCIuJm+8Sb92+VIJCIdvVYA3iNoyTK7+6GE5u
         NqCfPMFxDINLqS8QqzmHmvHQMJ5+04z/ZTfYxx92fZrE7nMy6V2KRcS6ZXcA1PZColJT
         oz8+gg7kexH3CBh/bs7SW1hx1tH6G17iOXVD0i0jK8W1lEjEosxo4nV7A5mJ1DCHINzE
         lzBcz4OyivQBIVK2zmKovz5UEAA18tAObIxRKdgWDfBmJKIIsl8+TGObguqwlyCZyYaK
         9yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569487; x=1795174287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MW//+eO8ifeDOMCGO0P1S62YlRWi+XpqU3MxHUVvu60=;
        b=E8oCxLBlXwkRNEyuS3LD4vMMyHl8CEgw95Rj4qk871JtyNuoPPw+jtXLOt99y1WgLN
         Z3zyNjOMf/3AzaRBDUTe/p3vj470aRkLuxxNnTbH7rtNKjYS4NXra4r0QfExKoCwYgPj
         63MiYHmhsEJzSsiyiXU5dmu0cd4SsIuzapZTsDfY0fnztSSnn4ikU2MbeHdUp3vWKqIw
         vMR7VLNRC6TG1seRptSJxfDFN2Iq5X+egMPNa3uYD0C9mYNoUgPXzZjXXeBwQpe05aP+
         L4spXoy3r5uMZn0NbyhRCXfyr0pT+2pIVmFFMNjdoZu8lIw6YJo0DaXdjHvoZjWcwPzf
         2hew==
X-Forwarded-Encrypted: i=1; AL+hErEIXfWeXek+9raYH1lGdQRpw50UZJswGiQIRHlY4eMKgk8Bg6tnsnsSC2kfvzO9l+OHaFE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U9d9EZgE+6spZE7RNnZxRjJkYkM9avYTuSbr9hMa8XfIspk4F
	9LedMldRrhKUAPa0+TII3RfAn//8ds6k6SOxzpRypUJErwDs/gMOj5FYz4cLLFinDSNnEBJXLQ9
	umAu9Ty3PmxABYdrSV5hQDU6QWqzrGafe48yPl5wBwQ==
X-Gm-Gg: AYBFou3Rm/54ectJeohSL8thM4sqHnTyKB5x3NMDjx7wFXu1+A9zvQ/AI1S62xS8Gym
	S7ojfN3ivnA64XOQIFuDmtW23fUOHxy1d3H14XOm8ao7qLJQkz1PzbSXI9RvEk0xipFByzZIcz+
	e5Qg0t7mvqBP+lPbKodZav3ZXW9+i751t/2S8NOveUYSQTKiHuFCac+d7T9gwoAwAULzbqpNR+/
	mSF5pXombouhx32YLrOGziU25/bM0qmAhDFhlsqyRrhn1nbu9cp30IyV/UTWAvUm9+6Rj99qys2
	TXfMK6Y4gn6XkCkR5U+I/ne0LRlVYi/5BiXOgAs/oFJSN+YOYRTKfTLFO7978B8FUQlKVxhfY8l
	s5EFHuJatBLDO5rHW6/wTgXDZiCqT4AwTG6h4YgM8rEIQJ7bwBRjMJXXl1kpngZgqoFbbkke9Xt
	RVxXBpELr0KblMsFBe71lPazeR5kprTM5tA1J2ZRJ9IAD2QJ7nntM3xDg=
X-Received: by 2002:a05:600c:8b55:b0:4a2:a3b:7aa8 with SMTP id
 5b1f17b1804b1-4bb55a02927mr44985235e9.3.1794569486922; Fri, 13 Nov 2026
 03:31:26 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016101458.221648-1-suunj1331@gmail.com>
In-Reply-To: <20261016101458.221648-1-suunj1331@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 17:01:15 +0530
X-Gm-Features: AclHuK90R6Cy2P8s5V5asYEwdHQCx6nGX6JWvDYYKndKeaNm5EjrRpe8coA3QcE
Message-ID: <CAAhSdy2KUD5xXFeKY0OD=iUzQzRHW87KjCamPQxcdxK-riq9FA@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Set Accessed bit in dirty-log write fault
 fast path
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: atish.patra@linux.dev, tjytimi@163.com, inochiama@gmail.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	andrew.jones@linux.dev, pbonzini@redhat.com, seanjc@google.com, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:45=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> kvm_riscv_mmu_dirty_log_write_fault_fast() considers a leaf with W
> and D set already handled, even if aging has cleared its A bit.
> On hardware that faults when A is clear, the fast path returns
> true without setting A and skips the slow path that would set it.
> The guest retries the same store, but A is still clear, so it
> faults again. This repeats indefinitely, preventing the guest
> from making progress.
>
> Host reclaim or page_idle can trigger this while dirty logging is
> enabled, potentially hanging vCPUs during live migration.
>
> Require _PAGE_ACCESSED in addition to W and D before treating the
> fault as handled, and set A along with W and D. The existing
> cmpxchg loop retries if aging changes the PTE before the update.
>
> Fixes: 7705be59eb2d ("KVM: riscv: Fast-path dirty logging write faults")
> Cc: stable@vger.kernel.org # 7.2+
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.4-rcX

Thanks,
Anup

> ---
> Testing:
>
> On a HiFive Premier P550 (EIC7700X, which traps on clear A/D bits),
> run:
>
> dirty_log_perf_test -v 3 -b 256M -i 3
>
> While the test runs, repeatedly mark all system RAM idle through
> /sys/kernel/mm/page_idle/bitmap.
>
> Before the fix, the test did not complete its first iteration in
> over 11 minutes, with lock_stat showing about 16k read-side
> mmu_lock acquisitions per second from the fast path.
>
> After the fix, all three iterations complete, each taking about
> 29 seconds under the same aging workload.
>
>  arch/riscv/kvm/mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 78a1826c466d..042d1e3b3547 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -591,14 +591,15 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fas=
t(struct kvm *kvm,
>                         dirty_marked =3D true;
>                 }
>
> -               if ((pte_val(old_pte) & (_PAGE_WRITE | _PAGE_DIRTY)) =3D=
=3D
> -                   (_PAGE_WRITE | _PAGE_DIRTY)) {
> +               if ((pte_val(old_pte) &
> +                    (_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED)) =3D=3D
> +                   (_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED)) {
>                         new_pte =3D old_pte;
>                         ret =3D true;
>                         break;
>                 }
>
> -               new_pte =3D pte_mkdirty(pte_mkwrite_novma(old_pte));
> +               new_pte =3D pte_mkyoung(pte_mkdirty(pte_mkwrite_novma(old=
_pte)));
>
>                 if (kvm_riscv_gstage_try_update_pte(&gstage, ptep_level, =
gpa,
>                                                     ptep, old_pte, new_pt=
e)) {
> --
> 2.52.0
>
