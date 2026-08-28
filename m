Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D13B0589
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957686; cv=pass; b=H/4WBlfeVFLkIPJDlvb2Gf17MeJOK9Mut6YjexBua3f5SiWIjBqN76IYQo7L98+lAK7OTZtDScvVc36V4YAEaWljN9nomnzp78Sop+0NuFntJnhbv3vihJ+DNQux7bQ3TosVc0WJbdx5rn4jt1nX0mVXP8Ot23e12wsH/t3lJkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957686; c=relaxed/simple;
	bh=4unzX+NMpOtBviw882dRQzRaeXOD1/xti/3UhI1UIHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLAV4C/MNCcam0bg6ZZIaVR7JVBWSCsv7dcutYZRRw/KVLnbSqVlnncL40D0TXm0AkdXWqd4WlUiJvSGVpFN0eSk7pSwI9AI4aZ8st8nllyQyxkBSQt7iMQPy8jR64aWvsjzPdNDN5NcVYuY4KX+3ucKa4tL+++uPdV0bmxBgFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wMHSAsLr; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMHSAsLr"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52fac937235so45281cf.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 15:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787957682; cv=none;
        d=google.com; s=arc-20260327;
        b=RN6vVg210eHFfDI7O2M1A2MnBCUi8syBILDdin37AZaLu2VuNjOrvwT0lPSTGfeKfE
         vUX4m0uQC68zNI1+/IAoQek/P4BESXlj8HcNm8naa/FIMaVMWpV+QqOxpLp++vFVjfZC
         29AlN2gRJqkjaM9/SxZoO7sHEIq1W+DO9i8qmR6AlLWQ4BgOZ4bWCphHCu3D3wP3P0uR
         RukIaRZM5DZjg40zROGW+7PSBT7q24R1NE007HSJExRCw72TnJhefGjdUrbxOjkCp9cx
         6Nf9wu8qcuxln1BEFxaVonr+v0nO9WPWM1fz0xpZu5y7od2GFEwnPxuXxjB3Bkbj+IJl
         e6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4unzX+NMpOtBviw882dRQzRaeXOD1/xti/3UhI1UIHc=;
        fh=Ck+oSQkh7siq1BuYj4MRLFUr/GyF+iRwWVrXMPbIQz4=;
        b=CCkXiPbC6rag2gp+auSy6tLY13RIW8CGsDYbtdpc7ZiNOY7cIAb3p0mvVkbubYIOzn
         /cx3d7Gfc8UOEoqYtaFQGNbS9JRGT6HDmleA3qesWrjcNbuiDifoOlIrmYbmHnefC7yO
         s/PTlKgo2pGgWJgUKVkYy7EtUUUgmGn1xEQOjuCd+SfY/lkomlIIKzvQEnZIlJ6AzHVH
         fXmhVCoaFRX0Bmea7g5Fg983o+Wi21NNZSHhCglzoiGTZTagEIFh7BPMfQ4TtpDUtO9/
         6xxOLgOh2eEKtaLjsPCCu42DTqUcMqhUuB7zDKmmNAegdoKRss5C2tN4ajNSOoCXKZTy
         rqmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787957682; x=1788562482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4unzX+NMpOtBviw882dRQzRaeXOD1/xti/3UhI1UIHc=;
        b=wMHSAsLr+g0oMmhiM9FTgPjkcBiWjxQpgibgbgK7MxAStn/eevCnCH5vGGDmzhS9rm
         55uH+BvLDT2bkJiJwTEFco74f7YofNpsUnmDTCamqQU8DLfidkX38a6imF/2NQwJa4Bm
         IwQn0FRGSvZwGKGpNxcsKVeAPB/2/B7gImXQcKsYuT5pF5pUHLRcR8g9n7dij0diornD
         tXGn0YQzMS0GAqZj5y+kDt0WQ/BLUxeiSKUug2Nj19z0+D4rV9aw0WJrRI9KDUPhl9C0
         kwK0kKErAqORoU4C+j2X1Q/bGRmvfGWHJv+q/yUwnw0nQp+agxVTbm6sk9EgGKZxihnf
         w3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787957682; x=1788562482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4unzX+NMpOtBviw882dRQzRaeXOD1/xti/3UhI1UIHc=;
        b=hjG11STpAsKLEBhUMBNi3SiaL1EdipNWGhb4pHWNr4A+lRavBfrN99tvR82X2Njj0P
         Kx2AJwtP+UEv0wkkOvSxOUI8RRGOPJXTVozQzcyBhQZYIKmJ/xLLPvnWQ6bHr2+MScY3
         lbg3m48QtPPbn43zOi8yOTn6R4JmLEu0OWK3VWdmMQD8kb+c+jZAguGnPmpJIjciGXSu
         mbUaj52WemzeUXuFk5752xSzvAhzoL2rjWULKT3eC3qZGwBeFmLs8v76t0KaJjlhEJIx
         +04b/YwU6SjK3Tg4EoCZi0GMtF2w82VabcdpNMKCnEFl7g1XPn0r7oEo/7r3N+lpSTgA
         N3MQ==
X-Gm-Message-State: AFuF++mVWv6MfsOOQXZosty/h7Eg0TqXBBn5qsBtHUNcZ04J1bKAKwJA
	3AT5vVlXyNHNV37o+6QpqRflV/f/6Wj/jFyITCC0JbjmWnf/LYm/QYGiM2HtfTZ6625XHUjs19E
	zYvPNAJGQd0Q8XwykTNGnVZ+/iPh4potZ49VyFfop
X-Gm-Gg: AR+sD13kdtp2jtV6/Xfiq0vjwEyQLe1GayVKQ9201/LdDkd9nxZg1oDj9jApB07F/Qv
	H8I9siIn113VrnDzDJFvi9PICBrFrWHwFqvvmSOaT+NdDaJCvyJD0jFVD8VNmrlAvnj4K+2sSU+
	7O/g3utetL4UgsKKy7FhzA4sPQaPa5iC7Pa0K9zEcBsjt4kRYSZYgdmKmKLaJlX6E+kG39Q2AW7
	fW6vLqTRZNmf2ay6k6t6QvFfxTa2wcjIz/McYLsH8fsUoNv6srE8U+TwO/yiV7N2322ADueZX5W
	heb9A9A7ruy3gEgkSDzYqlg1sAIbv02JBdSl/Oc8czpAZn7snphARdWDg5A/V9I1Jeheg/ez1Zl
	8
X-Received: by 2002:a05:622a:5a14:b0:51c:6b7:d3de with SMTP id
 d75a77b69052e-52ff716a2admr5298061cf.5.1787957679730; Fri, 28 Aug 2026
 15:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
 <20260806020850.1221381-4-rick.p.edgecombe@intel.com> <CAGtprH9ERb_fFG-4JYR1Bjxyyvnk3Ys4q=9ioQz0Cq6QCXtVBw@mail.gmail.com>
 <9c0048b72834e7e88cb278476ad8d19f57373aa9.camel@intel.com>
In-Reply-To: <9c0048b72834e7e88cb278476ad8d19f57373aa9.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 15:54:28 -0700
X-Gm-Features: AcwNN1UEyg9LUIjstN53o3MhfwwMAKPLjXkthRuE3vRI8Rovt7_F8Pac_E2pZ8A
Message-ID: <CAGtprH870raS09USeB=Ec_TAY8Vke6-nV_LcX6dYZVn=wEhjNg@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page() helpers
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, 
	"Hansen, Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"hongyu.ning@linux.intel.com" <hongyu.ning@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>, 
	"Gao, Chao" <chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:23=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2026-08-28 at 12:50 -0700, Vishal Annapurve wrote:
> > Reviewed-by: Vishal Annapurve <vannapurve@google.com> for the
> > SEAMCALLs and the get/put helpers, assuming your are still thinking to
> > shift things a bit between the current and the next patch.
>
> I looked at moving tdx_alloc/free_control_page() to the next patch. But D=
ave's
> comment was more along the lines of just commenting the limitations. So r=
ather
> than disturb the already reviewed patches at this point, I'm just comment=
ed the
> limitations clearly. And then removing the comments when the limitations =
are
> fixed.
>
> So the only only code change here is temporarily prepending the limited
> functions with __.

Sounds good.

>
> Do you want to keep your RBs?

Yeah.

>
> Rick
