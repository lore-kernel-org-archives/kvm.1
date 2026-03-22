Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730D346FDA
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 21:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215314; cv=pass; b=n4ylQkN3CKXBIJNL2m4Bgp+h4xKi6Nb1Xmc7B9qJ0Xi5zNqeGvgBUyTLp2Ms0xTEK9ADAs16TbLEhwMycuYlX98/lB36wLqfn917E0JEWbVOU/2ObCi0KvtdObMM+Bj5tG/oSuiUk2aLwvbLcaaHRWUW1A4E1FeZUAWgSsV+E3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215314; c=relaxed/simple;
	bh=gApkGcqVPgdcTYd4jmdPtaYkG896cUuh/RvuIah88Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlUmOxESJqq+GnJ7k7+mrBJ/gbmx0HmR9tWiCQo769B8qYdsyDikBjO69IzY9KBKVD/BOJUTCq1v9FF6apjirCX8nNR4f6Ej1swjVprkz8Cg0nnkktSZoJExnQnThqkL3ZKd/uP+nXLiAUuuaLl8ERTatCM0MxAbIlAUSxjzWcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/pusFke; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/pusFke"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fb990b9eso105495e9.0
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 14:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774215311; cv=none;
        d=google.com; s=arc-20240605;
        b=D4Q3eW6Lrx/+GfOy+R+4eWxKI8xtsY2UUNGt1nuPn1DgFVQ2RFHNyoSdTDOFySvXQa
         dzwOGHxCfXB6flVQ/m8zJVN/aF1L4lxjokC/HlRQzDDfrRckIoSMF7r/mNKVM3ueI17i
         sDXVj0PXTc/faCprGnMGWGLyuoktu7MtFp+WlQT+pU0TuH4szdjOuSrrh67ZTmdGS8ne
         SG1BHaxkE0KHx9Eo3EG1uO5qFwZFJ9TpGHlWncMpBk/hEs3aZX8Q8xGLmPryHlBeQp/P
         7GPT7vvGgco44Tg4olf+AGd4KvaJwJJ6Mx02vJ3LEJcb+OBLCSsmNnlK7HX553qrqHi7
         s/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QTIWcKBW9Y8RO9y4afCKJvIbF+a9wcxS5pN6QSrPCVs=;
        fh=1DUHNxRkgh7mUEFmK6dbUhOzGAhMkO/DB+o9zZS2kYU=;
        b=A35Hsn4Pf6AoltYL4fLW9Ga7FKvDeoZMyGgWzOCr6IpmFTI8nGBi205AljY8b4VDfO
         3FNZmhUmuVMjmVQHo8OQVx3rdXkflPYjzN7nIQxVuQOsp80myZCMlLp0ZoUsdB6q/E8I
         lO7SjY5zjbal4g0v+WosIxt9fxUZV9z7hZ3039baToBCA0dde8hVgW7PZuydUR9eXOZt
         juoH/Y5JWysXU87k2WfHlTmlgRo8K7prO4kBBTeYI19tfiwQ5Qddf1tdWu5Rsn5Fze8V
         QRXfk0uNK5BKkomTrlG93U96CLDPRc39736xVQMi1ZxoY8bhU7Uqy7re3uRdmNgaxzAo
         tmXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774215311; x=1774820111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTIWcKBW9Y8RO9y4afCKJvIbF+a9wcxS5pN6QSrPCVs=;
        b=N/pusFke9AK91UCi3IwyeLdAdi+EA3lXR27UMWNY2xtvDj/wxmu2dePcxAkgQLO43a
         H0LHQYfr9W+VqSllale6ahZZIR0/K6UxkLLG7EmucfChoXXPc9+Jy3y7Z9KXC2ap1WyJ
         MmvkkPzGD/G5Esvyp810O8hDD6HqH4iR0w94b7oLpZVX+inAyWt6n8FsotvEgXoY+u9J
         tYeScjDFlv8izq1mkESOhlQ8vDxPWIOzNnHUQMB1Ye0oAKGMMLUqxixLRHT+jhiWMfnt
         9ZpKvrr9YzEfI/kTl5ee+TH2JZg2wVT9gOAPqQKJAmpbHLOTdvuv4+Bn1GgCmFRT1k8t
         VqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774215311; x=1774820111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QTIWcKBW9Y8RO9y4afCKJvIbF+a9wcxS5pN6QSrPCVs=;
        b=IyoVBnxs1pV/dwl7mLK7WwROiQxBMgLPzbObVwQKN39hxbJGceuHlhkSTJ2MiLkcDN
         sT2srrFKHEIJgqGjXxiFW0/sZGAOJ2CxIa2majD81GBn6YTnAXpsBCxtZ8Q0wtmB9ATg
         qt2zESR4zHbRvAoXxB57vSPCnpYS/e7NxdXPAGkxpxZUKdxriI9ew2C0zAeM+T5KMAQM
         tIItI/BJ+fo7sl97UQ+LmfV/iMnr7r/VVGR5dV9hktOV3aFCX3j++WTEVRzkXT57qN2j
         h6kd9rZOz91jvd/ziaLtf4E26z7B77UJK0vOEtvcsQYFdw0DtvUtYoI+FyjkiQ+FOCq7
         RdFw==
X-Forwarded-Encrypted: i=1; AJvYcCUqxzCExPdmpe2kOp++QKrMkhSYZz97n2/r2SmsC3IA58PoSCQoqLRpbnSpaqzVIH4UiWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYtDlWgTrEllMLIS0QksHC7wf2vQKyzVWakqOqDGyptQNqh6q
	4ipr9pOYIHY45SzVPBQnNGe/e3R86C0UT5r+0x5VrMJ/eySIQzqWtb0guAuKogFPv1lDGhb9oNM
	KJhSk9j8LwSmYsoepoXs5oPdJyrvN5Wqrg8mwwrJl
X-Gm-Gg: ATEYQzxJh5c1+bWBQBB3+SBuS/MC5Zk2zFE9pS2AhxtH9fyWgshXcwFeGXe3IErBKGN
	nm1Etx7uc+lDO3m7Imj/CaxKtOtxHf2RD1uUic25kbQ/CCyiYRAuL2aZr6Fm1u/fbvWCfoCyNt/
	TePANfWH4TGk23n+15vGFiRCC2m+0r6+7qayM70Gwuhs+JEukUF7QqlktfQ0unFAaZsV4+zwtt8
	bqqxenM01zVwYEj1l32LGAPOmP1/wghHVY8AFcQJDoZjY6s79huUVa/a1bULxknLpz+xSJ1RYRV
	wAdYIXqzyzdc05cG/Z2kDCh7L9L7A9B4FXMXZBrW
X-Received: by 2002:a05:600c:a215:b0:477:c5b3:7a9b with SMTP id
 5b1f17b1804b1-48703466f53mr1053425e9.10.1774215310721; Sun, 22 Mar 2026
 14:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
 <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-1-92c596402a7a@google.com>
In-Reply-To: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-1-92c596402a7a@google.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Sun, 22 Mar 2026 14:34:59 -0700
X-Gm-Features: AQROBzD6br59NzV_GjGVBt5AZrKUozD0iHX3HE9KQlgwQBNQ-oe36lFLzYaFGVs
Message-ID: <CACw3F50mVpnS7TQy_pD-KV=_Ekepjq00zZzdGxwLnF_vYT_M0g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/7] mm: memory_failure: Clarify the MF_DELAYED definition
To: Lisa Wang <wyihan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, rientjes@google.com, seanjc@google.com, 
	ackerleytng@google.com, vannapurve@google.com, michael.roth@amd.com, 
	tabba@google.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 4:30=E2=80=AFPM Lisa Wang <wyihan@google.com> wrote=
:
>
> This patch clarifies the definition of MF_DELAYED to represent cases
> where a folio's removal is initiated but not immediately completed
> (e.g., due to remaining metadata references).
>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  mm/memory-failure.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index ee42d4361309..4f143334d5a1 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -862,9 +862,10 @@ static int kill_accessing_process(struct task_struct=
 *p, unsigned long pfn,
>   * by the m-f() handler immediately.
>   *
>   * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed.

nit: would it be worth correcting PG_hwpoisoned to PG_hwpoison'ed? as
there is really no "PG_hwpoisoned" page flag.

> - * The page is unmapped, and is removed from the LRU or file mapping.
> - * An attempt to access the page again will trigger page fault and the
> - * PF handler will kill the process.
> + * It means the page was partially isolated (e.g. removed from file mapp=
ing

nit: what about "unmapped"?

> + * or the LRU) but full cleanup is deferred (e.g. the metadata for the
> + * memory, as in struct page/folio, is still referenced). Any further
> + * access to the page will result in the process being killed.
>   *
>   * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoisoned'ed.
>   * The page has been completely isolated, that is, unmapped, taken out o=
f
>
> --
> 2.53.0.959.g497ff81fa9-goog
>

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>
