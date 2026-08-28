Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DA3AF65B
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787956689; cv=pass; b=U6A/SNn3AOzz4WzvwrXLI+HaGqhkEEaY9QnNbEZ0rTO2Y3V9fw2XielDpUeJJ4wXGJjsJ4+O6JQb7wqKQnSp0RIb6GcN/djf9FiMMkrs7AXjQpjTo7+vSo8HorMFl/zr40WUpyExWI4XwFeUAm4epnH91JStN5VBHayiZ6CipUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787956689; c=relaxed/simple;
	bh=RB6EgyhlXjG0oQQVZFu5K/wv2js1PnprY6edbmp2RAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2K8zjxkdbM3N768CI9huY88QbuJuiYkvUfkLubLmdjSnEo0+RpcJYSSanjOtxA1aND1FDohTX2pn8mwnczuocHxpP/kQmAayisxuvWcWTi2/tB4PJzDjBtjHgxoLOAZnowVeNAun6W9AlWn6VN06vGu8HF9HV1eB7YsWVqTtVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmWIH2za; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmWIH2za"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c01c79467so90891cf.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 15:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787956687; cv=none;
        d=google.com; s=arc-20260327;
        b=c8JFIBWSVXnkCdzb1xmNxd0ZEH+PGyLpAQg3SYK1bOzYzHjelTqlh1htIqR+IHxBD/
         s8BsihZIGmR3eBCyA5EG0/GnIDKLIRxPXJvULSgCsgnx3Mk1mbpESC+a/gJGIKIFqbBu
         LFWmXahfhuk/2P/m1rUGkVzDhkJ38R3usg1KZMYEWLI/PuDZK/rHxm2GYdqOJC0nedRh
         JJ1lkXDcPG/Me4NOZkp9jLTaCXOJRrc24NGK0BL2djd6EOg0aMTc74oHFmGuOQZ1hQa6
         KpXH/GrbjiViEaXtU4rhMCSRa6agvottFfn696QpG16WghD7aQwg18nHaG4vBLCYl06N
         z1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RB6EgyhlXjG0oQQVZFu5K/wv2js1PnprY6edbmp2RAU=;
        fh=4ShS6OnlfrnfYNzM+g7TZPja7VZiiPKggECD+9wxg00=;
        b=qCWN8zw/gvrmKNxtb82ibf5TwVVZKKnfExUSod09itSFeApwKkWZEIFtLhMfi2+Xrx
         U8af19xbZFcXqZxaBcNK4+145Nr8Q5Pji3ojZ7FfoZj5+60ul8xFjyWlbP2boYd7ZRRn
         fu48J+/W8Nquekxl5PULDbgGzwgk6KSbDwcaIRsQDAVqF1VrpVSAHSarQsc3JKZpWADn
         /qOZDWAOPs0GWz5gNkokp74JtKvuIv0xNaIqSrVnpRaveF2MreSEUcsjhbmjKqdS8xgg
         IeMIJ2REbkDhZVCZ6aMTi8AW9wChpxjm1TUZPPE9sYAXnLVs/5lW0jLss42d8MA+RqNk
         O2BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787956687; x=1788561487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RB6EgyhlXjG0oQQVZFu5K/wv2js1PnprY6edbmp2RAU=;
        b=hmWIH2zayiey2Fvt0dt8c2unjWcyurbc+HuvJKcK+4dF2lT76X5a+vJb8Hmi+HKlZd
         jQVJrrFIlVIDug6NbbcqtbcI1QqC7vhfIXu1r6vRZ//hYQU3KhS9Od8uNByDXhVSl1uo
         cFZkhxv2Pnw5/k4vf2cW2TOMa982UIwZ0P5FO7zCyfRbn/Eghihca7QezHaBEeafDRkw
         Ihvq7V0IMtmkc70g9+j9F0PEvbGxu4nKGBiGzAhhuAieod8I1YeA6bFZK5h77hBSvZ7e
         edcNuNSRplftd2U1v8yXCiidzHv1vzWUy+ZsMY6/HZG+UQ+Hhgpa+6CIkO9eZC2btCn5
         HZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787956687; x=1788561487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RB6EgyhlXjG0oQQVZFu5K/wv2js1PnprY6edbmp2RAU=;
        b=QBzmwj9S1xLmtHMZT5Fkug+NlSAMJ+akcP/FsZkMtsOxdwq4VKG8/4l4D/kP1GZbDc
         x5mPbaKIZv0hqnTMNfdNNjqID89hRAWV4fhT/5C0eXl/S7ythMwpC4Af4XdSa0xUSQSi
         geA3afHWRE90UaW1W7ysxTw5EB12gwtc9keO+H4bQhaSOGBVLqU9OiLAB1wu3gXmnz3R
         QeWI3kTP7XDbTq/1poYV2NJKC8Vc0TGY3XTtpgA5ZNqVuekktwTK5JIWVVjfxrnTV67S
         ntXdmszQW3BWi6SODxfRvWZvwR59fDPf1h9MTNCgqgvjQP5bzGDVpho6rkjBQykuRXbZ
         wbsA==
X-Forwarded-Encrypted: i=1; AHgh+RrFrcxlZjHYOc+xAewJdY4ZjMZcFYrNTAymysyHWUuC1XqAFqlQsU928JjXZnq7WdPu9o4=@vger.kernel.org
X-Gm-Message-State: AFuF++lPbPMPm7Ui6EdOwGgwpD6KVyDQIMNuiOYGFt0SUNjXTk7KnpSa
	r0Bp3Cijzpb3DFHJE1u1+nGG2yRvSuOePfbawMCX6N2L8jKoWvJRqFIXEyFs61CS8ya6tAHSabi
	dXqBodnouE66JdmdrT8MqR1Eft4SZXU+pJ3zNgpTv
X-Gm-Gg: AR+sD11EuV7oIs7xdxZKNWp89kTiI9ChuD8O2hqcLfmdfO2QQ/yhFKcugZGtiV6G01w
	5tbFzE7NbVQgud1SFXS75Oan1SwcKQ4JUjoOwqTSkj7932RrjLkags2JKUxV7vaLiA1VdzN1ge7
	4UAzoIbP/ysxVLTunUI9c6mlwhmJEz5Dw12N3VjUcnFZEWlTMqFHUGoN1oDEI+tYPyRGZrSrRlM
	QzACoAUd8OjSd27aY44qxWv9hGsRTVOtNZUui/xoNLXmF65tWWAVRxIMmj5MQXwdG0uWv49/ZTq
	7GF/Yj2uzJWUYKZEMv8qp8UnBie6HNyYjf41+bqdMbj+5IO2rgNUPF5zNOWiFNcHDSt4kHMqqKV
	ucrWsiuhi/A==
X-Received: by 2002:a05:622a:587:b0:52f:9ed4:8d75 with SMTP id
 d75a77b69052e-52ff741283amr4482141cf.15.1787956681880; Fri, 28 Aug 2026
 15:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com> <20260806020850.1221381-10-rick.p.edgecombe@intel.com>
In-Reply-To: <20260806020850.1221381-10-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 15:37:50 -0700
X-Gm-Features: AcwNN1WYsa0jAMLKRbnvpEBaceT5sA4-DylkYo8BvJ2OG5g_t8qOkwUGOnWXXA0
Message-ID: <CAGtprH82XzEmV+y-riufdOTAzJRwDavUtsRQY5BS3hYMGheD6w@mail.gmail.com>
Subject: Re: [PATCH v9 09/11] x86/virt/tdx: Enable Dynamic PAMT
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
> The Physical Address Metadata Table (PAMT) holds TDX metadata for
> physical memory and must be allocated by the kernel during TDX module
> initialization. Dynamic PAMT is a TDX module feature that can reduce this
> memory use by allocating part of the PAMT dynamically.
>
> The TDX module exposes whether Dynamic PAMT is supported via a bit in the
> 'features0' metadata. Unfortunately, the TDX module exposes the feature a=
s
> supported even when it does not support using it with the number of keyid=
s
> currently configured in the BIOS. Since no TDX modules exist today with
> that issue fixed, make the feature default off to prevent users from
> upgrading their kernel and encountering TDX erroring out when trying to
> enable Dynamic PAMT.
>
> For the decision of whether to make it a boot time option and/or compile
> time option, consider that Dynamic PAMT's memory savings are significant
> enough to make it a good default configuration. That is most TDX users
> should want it unless they have strange keyid configurations.
>
> The feature increases the kernel size by 2KB (when TDX is configured in t=
he
> build).
>
> All pieces are in place to enable Dynamic PAMT if it is supported and the
> user passes a kernel parameter.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Acked-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
