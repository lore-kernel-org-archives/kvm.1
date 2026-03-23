Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02B15665C
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 04:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774240900; cv=pass; b=VB0heP0VUhNz+jwC1S0Vy79VKRPJz2WOA2/Gwf8532qBw6jYYQsCNdmho3Nbbo3dXngtcoh0lSR1IeKxvHQpqWJsIHmoNHEDiDIBIcZJ+0tQ8YIObidu28j0A/NIL3ZRXta5Wq/295fUyj5nj28Yo3aBlNylgr8yemkcurvKfZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774240900; c=relaxed/simple;
	bh=5xNAgkWcLVlf2KUnTnCnuh9StTvb2xpehaXlQsqjq+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Crh3GiwGoXYL+ApjnXo3KB/O1rssTsliUbyGyPL9/Jwpehv9+c5qKKCNRoeaop0NZbHA6jzkotS7aOitYPZxM6VuiJalcOrzLr1uiLTAtidZfNJ5f2jUIB/0iGq4XlBJlp3DBk49V1o001Z1Qq1lFGWPHjKfaGntkzXzf8yG9Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIF4QNMQ; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIF4QNMQ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-509062d829dso1025281cf.1
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 21:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774240897; cv=none;
        d=google.com; s=arc-20240605;
        b=AyzKRlbfaOiZt1JLnnuKvJc6uc3Wx/crofCNmKQlvGEpdiqp/NWEoJRTbzgL6qPN5A
         E87Ha8WGX0n2RM1NXD7CWvLz+mmhmsZAfMvAEGO0fcbxiCNYHPX1vqAXGzDqm0+4EE85
         73ZZhAw90wqGbslQhFKbQ+NzMF73HzyHXZsIeUgQIOYBG/kkbYpDfB/c3pUQAfXzbMw8
         DJ/tfUYJj4mX3U0q9RDcHY2DNswGBwAs1qw4DCFwS8Wt4GJAFx6T5so6VC44n2vx4hgC
         FYuX+As0nRweUyImpbV7cK1h8ubrJrf/enaaVcKDlkfw1KKSZzxSN8Ys5Osm0RFQSufB
         C/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uAOJ0UtmqAYIg8tHB0P+xEtvsI4x8Llq84MC09xgdsw=;
        fh=w/kiyXeiyo2VdEmU6RdlcTd0gOY+6k4PVOej2rg4BAY=;
        b=lsCtKP/nkX4em7TGuIZrfvbCSopvmf/CT0072vDr6tl7k4XxHXF2YROQixydSqgK+4
         Z6/EEM4GGKU0WnH/LPXmLofcWJDNCtp+Cifd3Sr6VCrn3YWAMmqTQKNxu/RwQIw9lGq2
         p00JI/UP+fsrYHBkLiwkn9VAXw6Y+IbxwTd1pLX5SEidJpdM0Cl45ep801kqauV4sgTN
         sI7WahHOetdLftLe4xfVTd8/G7I33c6WPIIYQAAX3nsl5i0rCXabutEzXRdKJDjI4QWX
         i5QzBG+dhMsg50uemfVomgqjaLjC2i9adNfLieEY7Ma6fMQtoxcQh5eQpLD0JsHSrEw3
         UY0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774240897; x=1774845697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAOJ0UtmqAYIg8tHB0P+xEtvsI4x8Llq84MC09xgdsw=;
        b=OIF4QNMQptsDb2cFl6qgPUdviw6bMg/8DzsLDgGAduBdYGux/rVjVZwOuBouvEcAyD
         efBVrmLekPCkPedMA3yrcv+tQIWNFR74MOfUBHjRNsObDSBNy/lfdo+BsU+U9EJpix6v
         p18T2LIiWfHRtskC2jrHeoavI11bKgEEZJ1h/JyTdSXGzvCk+q/nzLZwLKmnwTbkMLsu
         jboVEE0OnCohKij20fnHQBIhoTM2qd2cX4jofqEHzqC/XQD40kI/pPFTcmIAr4ThWQYH
         D7UkEYaY8X9xWUksR/gOzirhH9fOIzhRSc0a03i49ykkCj9jMoltEJltYD7orLpCdpl0
         7/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774240897; x=1774845697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uAOJ0UtmqAYIg8tHB0P+xEtvsI4x8Llq84MC09xgdsw=;
        b=LafwKZdBlMvrOqitLn06OGErvDtfZFHkLeeCjcToEuEKsk2yAKQGzvGPJeb9Dpq6ZQ
         /GF58QmN85dxCcLR6tHLZfp//dJmmgJexbnvDb7Uqv7MW4mdRbh50taErwpZlrXBrAEA
         Me2JEBZuBrOmHr5ErBiRXJu1fRSC9ZD+BywP6IDDSAVwkzrMWPXc2gSJGeMPjNFJDM7u
         KnA14tNjVhueXQwfbDnP9YT0FwZnxU1qW0FMnOv2FqbwKYHSXik0xbJuuY2punSR0JWm
         p5Hh+PZTTIklI2YJs/+HrUMA8QO/oKP9D3BwrdPgZpxVaVhC6NnEKvrhHwzZHPSquy2D
         EW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRsDBSBCsspE79NoDLYYDdceeft3CycbG6F4Iki9Ex99lVxaJ0E9BqPlKp6urn7ZcVRv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YympoPp4J35PtTjxFf459AAXX2xlfeRBaDebqq8EZgY5YQq6r7R
	wXRTRK4NciTSz05nPzgseQKNkh4BCLBkpq3Jvg50e3uR0c5sZ8d2++He/Qtgq8MPuiHX637JOwF
	ZMENz3SzlqZEtakdUBuEGfa50ylmIK6K7SE1zdD5o
X-Gm-Gg: ATEYQzybUVoDk4CHVWk+JheOBSqaWWbngxpvo79HcOXnHL5VtpyL62aI+BkCMNHn2rt
	oPYRPum+Gdou4HK8bZTZxXFw6fm17OTojKzPrmFKWuG9m2LyJJOdBYualgGoE89/1cNJGNm3NpD
	vDBgThfGj9eP03nlH1WGet3cRbP0cNULGGUjwnUKX7nnhN8iFRvwzYOH1T1B7zP9NvMQMXZewvh
	LJeq/CAdlUuXUEIJwYC4+WFuGgS31tz21fvVgfPJntce2sj7zTw+1iQNuKSUrf3ImKRp1UJX33a
	bliQtA==
X-Received: by 2002:ac8:5c8b:0:b0:507:35b2:6b9 with SMTP id
 d75a77b69052e-50b48107de0mr21777311cf.7.1774240896259; Sun, 22 Mar 2026
 21:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-4-surenb@google.com>
In-Reply-To: <20260322054309.898214-4-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 22 Mar 2026 21:41:25 -0700
X-Gm-Features: AQROBzB-kgyO_oEQY20cC0lvKSqR0xCjsdgKi5Q7Yl3nGZ7l0Zr3zEDlsBs17n0
Message-ID: <CAJuCfpHOy7QR1Bk4tA_JNzeS1M2OYEJuuxuZeWjnZoY3u62B5A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] KVM: s390: avoid kvm_s390_handle_pv() error overwrite
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 10:43=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> If kvm_s390_handle_pv() call fails its error code gets recorded but
> execution proceeds as if the call was successful. If the next call to
> copy_to_user() fails then the original error is overwritten.
> The follow-up patch adds fatal signal checks during VMA walk, which
> makes it possible for kvm_s390_handle_pv() to return EINTR error.
> Without this fix any error including EINTR can be overwritten and
> original error will be lost.
>
> Change error handling for kvm_s390_handle_pv() to alter normal flow
> once failure happens. This is consistent with how kvm_arch_vm_ioctl
> handles errors for other ioctl commands.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 3eb60aa932ec..ddad08c0926f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2947,6 +2947,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned i=
nt ioctl, unsigned long arg)
>                 }
>                 /* must be called without kvm->lock */
>                 r =3D kvm_s390_handle_pv(kvm, &args);
> +               if (r)
> +                       break;

At [1] Sashiko says:

"Does skipping the copy_to_user() call here prevent returning Ultravisor
error codes (rc and rrc) to userspace when kvm_s390_handle_pv() fails?
When an Ultravisor command fails inside kvm_s390_handle_pv(), it populates
args.rc and args.rrc with hardware failure codes and returns a negative
error code (e.g. -EINVAL).
Before this patch, execution unconditionally continued to copy_to_user(),
allowing these diagnostic codes to reach userspace even if the ioctl
ultimately returned an error.
By breaking early on error, this skips copy_to_user() entirely and silently
drops the updated rc and rrc values, which might break userspace's ability
to handle and diagnose hardware Secure Execution failures.
If the goal is to prevent overwriting the original error with -EFAULT,
could we perform the copy unconditionally and only update 'r' if it was
previously 0?"

[1] https://sashiko.dev/#/patchset/20260322054309.898214-1-surenb@google.co=
m

This might be the reason why copy_to_user() in the original code is
called even when kvm_s390_handle_pv() fails. Then I guess it would not
be a problem if copy_to_user() later fails and overrides EINTR with
EFAULT. We could avoid that override by checking if r is already
holding an error code but that would change current behavior and
possibly the userspace expectations. I'm more inclined to simply drop
this patch and let errors including EINTR to be handled as they are
today. If anyone has objections please let me know.

>                 if (copy_to_user(argp, &args, sizeof(args))) {
>                         r =3D -EFAULT;
>                         break;
> --
> 2.53.0.1018.g2bb0e51243-goog
>
