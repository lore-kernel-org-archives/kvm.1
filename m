Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9C361962
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787958061; cv=pass; b=I9V9v2LYqmcSti96GtDInmAXfovTNfMb1zfK1b0q2M63xjONvantsGhzJ33sBHM+tqkdCYoAqdttMwr1b7fTKrTvYfwO2sQ2zfJwroqgtbWzlzLlaL3cmg9UfCLvmk2DJ4/xG8zzx4E8igsrEmzPwQ0+VRDFn2jO1Idtl46QdPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787958061; c=relaxed/simple;
	bh=6T0r+7hZ2bdIBBi+tmMfu3lgh+SjUf2cA/8NWF9EmJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjOprG8knMgGGr0oY1OczLYkdUOQR5auJcEE9204IbyhCypFhvo9nlyKdfsHRjR5dq2BAZnCbjSmtr4elmwfO2v2XBOe7Ef9vVmrBiRhB4Gk74uEZm2b12CVPvFaJ997VeIhBi28/BKEdsGjUOCeQyo3EWgjpnXHT8jNKmio+cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfs+XXKA; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfs+XXKA"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c01c79467so94511cf.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 16:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787958058; cv=none;
        d=google.com; s=arc-20260327;
        b=IrjZMvtVwm45UobgiyNW0JQ0rOdRgQwYdvjw132inlF8ypqvmBwq4azoi6gELVxnST
         jS0eXiPMFIOQfzQpIRrqCD0dw3ED3V9K1dz0IKK4aj8SuaWWUuKkSKAPRZfF5NnGlk44
         6QNz1SKziLlSOdE6oFF0fxcy9Xng4zgtCxnoqVYVm1k49GKPaVoS44E4qXu4aDVGN3Sd
         5RQdUDgfYYg/RtJB84qCthXbHZS4tSa3hiArcFg9li+kF60WS9qYFMyCd3yV9pB99cJ6
         pTcPPzMG5aceMLcbHC7me9qI3H6Rmm48YNNZ0T6hznXqJ9rSqpVVTdEqGLw0w7R22LaL
         Yznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6T0r+7hZ2bdIBBi+tmMfu3lgh+SjUf2cA/8NWF9EmJY=;
        fh=cocM1tQxRZLL62IFPgu7/V1P2TR60oRUVCdnTnDUjSg=;
        b=OYU4eHKxTJe6/HxDnMmR3tUzrQHvZy1mON+rjW5zpqLNow2iJCIm7IShZ0wR7ypC6u
         6/NRtQxNu7PFXJrTZm5eMmX5aE5dpLtZlTTU9hOAhUIVfDKptpVbTO2suf+bo804Azjs
         Dm0arP4z1E4p5G/m9uWj5hWPVdYflVl8oVmnXkb9vQ2CCw0Ov6E/KvotfaFhAiuZSTzs
         SHxW29kM2thO+dF+3dXdWbBt4kmEDY6lfcQKUeiuPmx2pI2yKxDlYwBXrD3ctnCPnpS6
         q3l5VAyFeMePJkFQ0Wfd3s46Gtc8HG6rRZQn9E+t6xQK9IHWAiUTcXWoL/AYC0I8vjQm
         iyyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787958058; x=1788562858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6T0r+7hZ2bdIBBi+tmMfu3lgh+SjUf2cA/8NWF9EmJY=;
        b=rfs+XXKAV3nWEbM+vRBU0MVTbjX//gooTwM+sXJ3KwGiCeZb8hl6ST3wuMbNGGl9Sq
         3cFqWWyNtdXwSyZlxiwCFkdmO7gWn818xZHXKC3Z9fYXUfUXt4AHwc1ZIAP6xYiBUFIB
         QKwMc/3zHN7f62gqroG3T9/GIvStH4OaEaf5W5r9xX28JkHoB3mQGretzVbD0W5xUsoy
         TGRXQXMDqk1FQ4BgVOYmLOHmGa9dhIAgkrprqd/0xvY1S1tZmPJdG6B/33Mh01TDfIRt
         H3Kx1SpXyHqeQxqHnO2S9GBycdbmYCQUSXYmWa2B0wL1mDmcG/3FqnVSzbVJ93LogpPa
         L9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787958058; x=1788562858;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6T0r+7hZ2bdIBBi+tmMfu3lgh+SjUf2cA/8NWF9EmJY=;
        b=EORtNA43Q8SAe+0ADF8886yuXX9OkRT4xA/iGD7h/ElhHhvBsZ5BRXymN10o61uwnj
         gEGlNqVwlu2qFAHeqPPr6DT/RwxDEjO8uIyiGxdqA4qN0RtwkVKO1Ho0q9NEenzcdCWR
         shfSWybU+wVXW1TTSMuDbSGGcQb6pdHJ2R6g8ykHuIx//eNQAT6xolR3Tp81H7hq8Y/o
         rHZG1Bz+2NV6e9mfHSUpFWAHNE9QrtOqvSybEH4N0piz8oTvzvnSuNGpdVoOXaQ6VDXH
         QdzbrxlnLqUNZbn5PK8Z1X7sOooS6yJ43XpCytdvemChQ1dKJoSP+ZvzxKZmdmozZ3mx
         5g3g==
X-Forwarded-Encrypted: i=1; AHgh+RoJeGQCAHoks4iznFsErF963hljn5nsjXfSXCMV9PqiqSkIK/VvBtDaRLL/SOZKIHJba4U=@vger.kernel.org
X-Gm-Message-State: AFuF++m9kZxFvZ0Cp9JqICtNFz7vULN0CnWsfUg2qxmgPKfGxq03p08m
	9+DP7jOmnlSN7x52g9hKf7VcCgbvjUVhSkuDPEPQGu39kwM8ZTyceZeLx0CJoOhWeLMokfB4Gd+
	ehbzB+NwfhIVH0x+Bg8+e5l0l28lKSULMolSycujL
X-Gm-Gg: AR+sD11jnbzSQNitR4IzwHd36kBOVSDiEcEbdcQQ+FetV/BAgav1q4svjsAFy47Hvz3
	GUdw0xiZAYMzT20QYNFplyMuohGWtqO/LA7wVqWJGH9o6RPAH3PYmC5BNDYviJyAkxtLS6nugJa
	TbT2r/9s0BRMTXZ8rjSM3THcAjI5ykjqDkfVlFsZJuC4FD48iNtdxTYdXEjnaezgxc+U0o04Evu
	eCq14ombiFrM+CQzwx62iLy9pdx0euiVZgbZ6XJtgTF+pPkPNXogdBQo5L4qeXIW6URywu5Bpas
	U9VsTORXvdmwzWXsDdMrltB1CTGTB7jAV2dDrOaO6YG8P1QyL0ctRjNz5hePHr12TMdIoFzTbjc
	=
X-Received: by 2002:a05:622a:e3d1:10b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52ff716ce29mr3942111cf.3.1787958057424; Fri, 28 Aug 2026
 16:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com> <20260806020850.1221381-12-rick.p.edgecombe@intel.com>
In-Reply-To: <20260806020850.1221381-12-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 16:00:46 -0700
X-Gm-Features: AcwNN1X97irb4_j1CgiMkl1NpgrTMyQT9MylOIwj136cEwhgsDcXkqEaEWN4fto
Message-ID: <CAGtprH8-7_C_CQhKUj816oYyEH_RBPMCu+yPQwhvoAkSkWXapg@mail.gmail.com>
Subject: Re: [PATCH v9 11/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@intel.com, sohil.mehta@intel.com, 
	Hongyu Ning <hongyu.ning@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:09=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> The Dynamic PAMT get/put helpers use a global spinlock to serialize all
> refcount updates and SEAMCALL invocations. This gives correct behavior fo=
r
> concurrent callers, but leads to contention. It is especially bad from th=
e
> KVM side, which is designed to allow faulting in EPT under a shared lock.
> With the global spinlock, not only is the lock an exclusive one, but it i=
s
> for all TDs instead of just a single one.
>
> But taking the global lock each time is actually unnecessary. Only the 0-=
>1
> and 1->0 refcount transitions actually need the lock (to pair with
> SEAMCALLs that actually add and remove with the Dynamic PAMT pages). The
> common case of incrementing or decrementing a non-zero refcount can be
> done locklessly.
>
> So create a fast and slow path. Check the refcount outside the lock and
> only take it for the slow path (0->1 and 1->0 transitions).
>
> On the put side make the refcount adjustment and lock taking atomic so if
> a 'get' happens between them, it doesn't cause the Dynamic PAMT to be
> freed incorrectly. On the get side there is no technique for doing the
> refcount adjustment and lock atomically, so check the refcount again
> inside the lock.
>
> AI was used under supervision to collect/apply feedback, review code and
> workshop logs. It assisted in identifying/evaluating the stale
> conditionals for the races resolved from the atomic_dec_and_lock() change=
.
> Separate from atomic_dec_and_lock() fallout, it suggested to change
> atomic_inc() to atomic_set(pamt_refcount, 1) in the put error path for th=
e
> sake of being more precise, which Kiryl had also suggested in the past.
> The model also suggested updated comments following the
> atomic_dec_and_lock() change based on some directed prompting. The
> comments were subsequently edited or further prompted for fine tuning.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Acked-by: Sohil Mehta <sohil.mehta@intel.com>
> ---

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
