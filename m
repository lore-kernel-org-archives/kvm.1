Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A521299929
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787945499; cv=pass; b=hZKmGBvQQfQUjI/q6XjFXV5lFiHJa19cJ7VSutyIigEs3r5vBLbMNWmfVNcWIL8wzIsq3SWXKyO7z8Qnc9lbiFKKoDpb4qB8x+t/GCn0a2mKq9tBV57KNXOlonocPs2d5daggYkcWvAXizO6ucBAFtEeKep2LbGgZEUOK7EEBtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787945499; c=relaxed/simple;
	bh=CdWj4WZBsPRTHGep9Z7y+jcoE1QqheNf+EyUKQPri1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlAj4lsuMBaut7DVIYpI5bVWWSYajt0Gjz9S+UVKYFf+wf1TDnkOpK6RtqGA+SOc5wsrS8eeD5FRoNS/TIRs5bIkZoWDIc5duI8vviV7NcPb7boxPvL4DhloUH9htPm6LrcXlWaxd98Iaw2RvLDDfNXP3wWuHYpeSMZdhyUuTWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJ5NaAfw; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJ5NaAfw"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52fac937235so44611cf.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 12:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787945497; cv=none;
        d=google.com; s=arc-20260327;
        b=g4o4JeIj3jK/OAwTYKabpH26WS44g8SaTkMO4/zEZPpwAg9Ciyrn0L25NZCRO3Ss/w
         USnIoV0Tgojdap295lVk9H9t77tYlvXAXFYJlRpUgU/Lr/1l63em3Fqd7rr9d7DFtZP6
         UkRZl2kO7eb2M5iMyOUKVZbk+tdng5fNMA0Jodlbrb7TEB77StEw/q6NcsKFweWPhIKA
         rxKfVSzT1GnRkn5acNt8xYMoeV2GXf6X7L59VDgGEaZYpin229Ku21deWbPAlxbAd7RS
         cWTcw7msd0tVb6doXWMA9WG4DDm1hX4VGpD9f3olDZRmdQhdlAr4D1olbBB4itx6L91M
         dk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CdWj4WZBsPRTHGep9Z7y+jcoE1QqheNf+EyUKQPri1k=;
        fh=NdqS/6LIoyfZZZayR+nfrmE4w8wtLuvxkao5m4G/bJw=;
        b=PrIRaCFL/FIhCSvFm5zchkNQkGWz5V6CDr29UK9SzvXoQSmBRlk436J7FeHSVMp9ZQ
         SGP51GkBucMgpt79g+EInI52rMvVvLz7gXXBOualpq16Z5ZP1HdGKJDtfij/k5Y8ePkd
         JRnD49pKR7BfT1g96f/tivLV/XM1n++2EomnSeZaIMHnrySMW35VAURVrtaIIrxB+ok5
         ngghzzk9CQcoBz55i6faV86/3N+UyMtPWi6nC23olv5SfsObETTAwuI7r0p2qv6osQG5
         aWUyMaqPUVa/p3/BThilNaGGZlF/Avt2NwfjTbMVYNt5GbdgFL/ipTZrRiZjlGg7ih//
         XlRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787945497; x=1788550297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CdWj4WZBsPRTHGep9Z7y+jcoE1QqheNf+EyUKQPri1k=;
        b=eJ5NaAfw8P4uATNYCemgpx/MsKrqNBAg7S8ZAbRgFISPT3uVfuQpBPqIebveNTMi/h
         eIx8gsFzTMQduQQWOi13h85K8lzp4BPChNOepNIZhYqlZv6vyGc5weZmY2w03xclNypI
         etayQYHcvkCwrfgcjbfrcIoS1WtOxY1+5dFk1WjFfh7XCbZiUj2r9sOGTPpUguV/+zDZ
         PJFDA4JaxlETT5USp4f1him/2nMvx98zz99glM0YkEpDKqbPR8YczqG83Sqf/kGA7BM8
         tsftUgZkmdNm9WD1gkcl8xo2SCqsIB+GibpDGvLSL/Z3wCLcQkyJROzNmO2+ZM306IpH
         JhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787945497; x=1788550297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CdWj4WZBsPRTHGep9Z7y+jcoE1QqheNf+EyUKQPri1k=;
        b=aFUL+Pw/+PeAzlNDwA2zMoyjL18ffm6LEUShDbY4/CnZKwaz6kJnGwenZwigiphi14
         pahXbnG+u1cQD5LHD/d8hDpsQupJKpd/JJodByki3ddxS7q7VBhUrPNl39rEsDBOwFVP
         gtJHIHDoEYw11AhJbUa/BMfzByNJT2nrAT9/+kr+XZ2TATuYRyVbsuQx8oixTdlgLG7Z
         yfBJ5bcEn5pO5ODm9V6BE2UQ15Ve0Fqiz9yFKBhFyZjOUh+0XoyKS4zvGn+L0OWvULb4
         zwO1P9mPbJtDfv7PAfkWrM/OBb6gRfuIwhumAQ06N2STyBfYfRT+SMs4A29ZOZ35os71
         QUzg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7uI4KBRnEW133eyJsn1CiTGnqtfE3e9ZO0bDCrF6p2en3O01TaeEdoUTsgnj+Dg38aQk=@vger.kernel.org
X-Gm-Message-State: AFuF++nmBprtRG93Iv9OrVVwj5ZQVNWYSpXH+wUfsUE1pCrDgRCxpK3j
	KVIWRaoXcYSctwcW3O1XeLTefd7GWRxPL5N3ACofQOowfZLKO0uBNot0JW6IG4qk7cOw3kxaAVo
	v3kAsXrJKr0OSgjmBWVeC/ZBumCN+23G7Zyyuvavd
X-Gm-Gg: AR+sD108pwJMM+O1rldcQt76abMYLye/rI+WqxjratimRQvnH6/+ptC9hXGtluSTVYd
	ogBkYKoLEHFN1Zm4ZhB8KAluAaYP0TkAwnOPM+KNlqkh5+kIvaAg+i1LfyK+ZGJwNOYocnqHZLJ
	2Y17M2FlNW8WX5VUjxsKbwmBCXxXvZXSnLw91ZVTzQdy2574YJVObp6eolYjk5QnypNMCKCbzLf
	RPAKXKUGauWD0/6chaZ8AL3ebLnAFtzVHJrGbTxqnq7qSB3UJYsESdRmW3V22O5mgELNP3IQI+Z
	WJC3CcInKgn1Ed9VTlD/EUC3Re+V6vD/XSS4GyvpW3r7tKhfCBUx7fzLksyFRYlckLM0QWXHCR8
	=
X-Received: by 2002:a05:622a:e3d1:10b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52ff716ce29mr1709001cf.3.1787945495743; Fri, 28 Aug 2026
 12:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com> <20260806020850.1221381-3-rick.p.edgecombe@intel.com>
In-Reply-To: <20260806020850.1221381-3-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 12:31:24 -0700
X-Gm-Features: AcwNN1WNSpQsijIEuWA2m2XaHo35MQhGxpQjLiFkQcVF5TdNjD6IsdWSCXD5vno
Message-ID: <CAGtprH-qD_P=_GTNmjKbhHk+ep959xcaP0PqUD-KgOv80=OPXg@mail.gmail.com>
Subject: Re: [PATCH v9 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic PAMT
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
> The TDX Physical Address Metadata Table (PAMT) holds data about the
> physical memory used by TDX, and must be allocated by the kernel during
> TDX module initialization.
>
> The exact size of the required PAMT memory is determined by the TDX modul=
e
> and may vary between TDX module versions. Currently it is approximately
> 0.4% of the system memory. This is a significant commitment, especially i=
f
> it is not known upfront whether the machine will run any TDX guests.
>
> Each memory region that the TDX module might use needs three separate PAM=
T
> allocations. One for each supported page size (1GB, 2MB, 4KB). The
> TDX module supports a new feature designed to reduce PAMT overhead called
> Dynamic PAMT. Under Dynamic PAMT the 4KB level is allocated dynamically
> during runtime, while the 1GB and 2MB levels remain allocated on TDX
> module initialization.
>
> However, in the details, Dynamic PAMT still needs some smaller per 4KB
> page scoped data (currently it is 1 bit per page). The TDX module exposes
> the number of bits as a separate piece of metadata than the 4KB static
> allocation for normal PAMT. Although the size is enumerated differently,
> it is handed to the TDX module in the same way the 4KB page size PAMT
> allocation is for normal PAMT.
>
> Begin to implement Dynamic PAMT in the kernel by reading the bits-per-pag=
e
> needed for Dynamic PAMT. Calculate the size needed for the bitmap,
> and use it instead of the 4KB size determined for normal PAMT, in the cas=
e
> of Dynamic PAMT.
>
> The existing metadata reading code was generated by a script, but the
> current plan is to stop generating this code, as the script has continued
> to need adjustments. So add manually written code and adjust the comment
> about it being autogenerated to be more generic. Start to adopt a more
> normal kernel code style without the ternary statements and if
> conditionals assignments that the auto generated code has.
>
> AI was used under supervision to collect/apply feedback, review code and
> workshop logs.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Reviewed-by: Vishal Annapurve <vannapurve@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> Acked-by: Sohil Mehta <sohil.mehta@intel.com>
> ---

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
