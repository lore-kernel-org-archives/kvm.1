Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742A3E1732
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950759; cv=pass; b=UsMUH+yadMHlvm4wZrQuJxznt+/u3j9LSroKQyaleSIbrDuMe8RMLEW2XoeXOSYH3iDWZOq8q5ocUC+Lj6ombADT32zKV8EmF0miRMaUBekMnxrTy/Zxf1DlBp9Yke6KPoBE+5WudvdwIRAFcSZkZZtOEzZJyqgZRp5xOZ8vlwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950759; c=relaxed/simple;
	bh=th9sS0fkvusTIUN5eNH4u0h4op6zM/ybXH1l5XRS+yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=in2TVd0rKsPm4RlmGMu6fGZ7OTUJmPL6QcZqq4RAdBySZIYHx9TCwP3Vncb4i/OfysAX7qH9yPICrN4n8m+LjLKmT75en6k6fyUeGY1PogkE/kxTqhIB4gykQxxhHEYWYLioHUJ85OCYabloFLQM+DI8jCV82IYQTS9DzTi3GXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEnwFclh; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEnwFclh"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52fac937235so21751cf.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 13:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787950756; cv=none;
        d=google.com; s=arc-20260327;
        b=gWMZbizwsr8wyPn1O/wFNLPIAPug46pA4ouKX5Nr974dEYtD1nh41VOa1YiIEHA95Z
         jpL7G2J7yn+d16oBUrCrJkTsVrvupZPCn/jzTaSL3Vi5lEFA+l05u3S8hNrlzSnrC9w6
         eqD6E0ypIHXiMb4JUP/yVK+17hgrlhNacUhNlu3K68didfGSwVaeTDNB5okZNWX8QBgk
         yftQkHuYDZVZ/gdpFkg5LE8jCeO1zX/0nzsgzBMjG/igBd4T2LgTpoUPkMUqoS8tifDB
         5H4tw0ee9OGJQD26fhElcqzI0zqxcApiPmPSR+qdkko19zyDOlD7heulrlni7az1MMBf
         psAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=th9sS0fkvusTIUN5eNH4u0h4op6zM/ybXH1l5XRS+yg=;
        fh=D81LAEztnj3pUu644Q9/RoLqpuREM1z7vQnsO/dF8+U=;
        b=WR0bs+VmWUZpvWgA4hIc1zNYEeaaM+JlLdkifkVSPjr6GVhFFEHSBuwxxk2YkKDkji
         jqK5QQDseY0bzbfJYguMvCR8bfsjJfF+fqHjvTB1CV7fCDTSB4zyYaD7hXIdCzpxbc3d
         c+8k3OSWjStV/rveYJb7oLmxxmyahdvvBdK7csGtl8f/vuIJ5AfijUU/L3BNUhwLNu/m
         c5/E1GVlbzRbASivIzQtOp/gFBGVMW7WAqB41llc/gWzpEmB6R1amnGYTRToOqAn9mSR
         V3J9z74Hq3U1dTq0dj6R1LYWnVBaoQ2Mh+qqbGKyL2Udqu4Syr3Jo1pmttM9oSOxbI4A
         wQ9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787950756; x=1788555556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=th9sS0fkvusTIUN5eNH4u0h4op6zM/ybXH1l5XRS+yg=;
        b=tEnwFclhlqyqu+78nKbipQX97BQGXYmCP6EpTkjj4+yLp641Y9evxUlqGAa3is5CrR
         uxIlvSenoCvGikzj0UoLWyOhyJBJZ5iSBsQizW60U0UwaepJWNtU7Ou1p5T9JbZKfJCZ
         W0DM2xaoB8S+QtwxTzNI6/9UD0BzW154Y1tgaswfTDTDeK0E8bfwMMYGFq3ZLD7cXQk6
         GDhgblPW35ho95n7ZpquTDKKTS928ENMELaPpSF4LEqBpVSrGnZ5PagJXQ3yIMNNJJaN
         ZCm9+mwQtIkzHYc0n8Z2XX1s7+Dy8SqLUzk9Llu3xlIJVO+ucpvgTLTD8KDAjTxYCgyr
         40nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787950756; x=1788555556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=th9sS0fkvusTIUN5eNH4u0h4op6zM/ybXH1l5XRS+yg=;
        b=s5G6UFpTetO5se+OLinYmIGZ9ZKnF8MO+BClWpnN/5U+gH7NEa4WXtxpj/iSe+LP8l
         hHcs0FoECIKLQm0bGdqsGE5oDDHOe7/SnwnVPiVT26lnUJOWSOyc4ZyQPlKMoTo0khzV
         vCpkJQxTDBIkoGoGRCdNo7UvNg1JoKkYnTcIzMobEexwcCvjE4ACs8rTHdmf4oO0szyx
         /H5p4hJkOivnP0xcyNTMnOLLfbN2sEDMObaRamf7GercOxYGZyGVlCZIHOTDszrzwriG
         2bfqmsRWhQvQa8pN3PEcgfd8tp3dobrknOyDE/83I2lPg2HDo0LJSTFg/+6cRmrSkVV+
         5r+A==
X-Forwarded-Encrypted: i=1; AHgh+Rrf53m2dWHnPJbaehrb1JRv6gSPHXLTCJ6CygiNH8uAWg/n47f2WiETYxRrtkX325SaGGo=@vger.kernel.org
X-Gm-Message-State: AFuF++nbpsH0lltTFBglXS/6OyOQzz03ypcBvH63SvioNj2JAQqr/k//
	ylWbT7sOWUfwNU4eFh/rCPfRmOQiRyOGndAUqly6fxhsyVbwqIfYagOxGU+T33+NoAM9V5Oev6L
	/LHLr0o3ABokFCCaJ3gRKmx9iHCWjeihoUd+MTpSs
X-Gm-Gg: AR+sD11W9qq8YQZVxM07XPlsv5vkPKkfroZF8i13Ypwn9Ocky5jWIQIL9T1RHPu13DC
	OudQoPA25Ny1debiYAFKKTeQa6LXLcJPhmGpF49VhespEtRcSpGQ5BoAMclpnfc1BjbDuBdB3qF
	j+xuhRMU4s6xPY9pgdoBe2igYg0b0Q9CIph0wv9AM3yfZMvaPNiVRmCbyhEBYMp3M8M9iWnzkRN
	PSj1pmyEG5Ex7KPUaROZtvShgy5jTMsOrCH1sMAZETzdr2XS48yrnmvj4HLqpE/1pydLkA74mHb
	JNmAZgiukaMBS/zLGp9ii7rnAgX5fUqd1+6bNfszaKpvxopWCjkiMfrur5jQ5Q91eNmcdZ3kckg
	=
X-Received: by 2002:ac8:6109:0:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-52ff710cdc4mr3278821cf.14.1787950755287; Fri, 28 Aug 2026
 13:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com> <20260806020850.1221381-5-rick.p.edgecombe@intel.com>
In-Reply-To: <20260806020850.1221381-5-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 13:59:03 -0700
X-Gm-Features: AcwNN1WI_9DAW_34H7aprFGN9TAhxXzmVTrVu3YrXpEKWiXKUeYdo7vi9R_t0vg
Message-ID: <CAGtprH-Xi8-UGWTkVhNnd1dkmtcnFJsXOsTjr=ijK53aUuH4ng@mail.gmail.com>
Subject: Re: [PATCH v9 04/11] x86/virt/tdx: Allocate refcounts for Dynamic
 PAMT memory
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@intel.com, sohil.mehta@intel.com, 
	Hongyu Ning <hongyu.ning@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:09=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> The PAMT memory holds metadata for all possible TDX protected memory. Eac=
h
> physical address range is covered by PAMT entries at three levels (1GB,
> 2MB, 4KB). With Dynamic PAMT, the 4KB level of PAMT is allocated on
> demand. The kernel supplies the TDX module with page pairs to store the
> 4KB level entries, which cover 2MB of host physical memory. The kernel mu=
st
> provide this page pair before using pages from the range for TDX. If this
> is not done, SEAMCALLs that give the pages to be protected by the TDX
> module will fail.
>
> Allocate reference counters for every 2MB range to track TDX memory usage=
.
> This can be used to handle concurrent get/put callers, in order to
> accurately determine when the dynamic 4KB level of Dynamic PAMT needs to
> be allocated and when it can be freed.
>
> This allocation will currently consume 2MB for every 1TB of address
> space from 0 to max_pfn. The allocation size will depend on how the RAM i=
s
> physically laid out. In a worst case scenario where the entire 52 bit
> address space is covered this would be 8GB. Then the Dynamic PAMT refcoun=
t
> allocations could hypothetically cause the savings from Dynamic PAMT to g=
o
> negative on exotic platforms with sparse, small amounts of memory.
>
> Future changes could reduce this refcount overhead to be only allocating
> refcounts for physical ranges that contain memory that TDX can use.
> However, this is left for future work.
>
> AI was used under supervision to collect/apply feedback, review code and
> workshop logs.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Acked-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
