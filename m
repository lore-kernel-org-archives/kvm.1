Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169573;
	b=i8mRr3JU7E6vl2HL3kumTBr3l3Wf8im/GhuAHBFEs0eA2CqRPtAhtX1vgSSTHHoD8SEX
	 OdAREnPID0534u2FD4eaJPjzEszGwtKGYByQh/CAAtkCEdcRA8501CsooM3LwBs/wzw6h
	 JM+efNdSug8w3HxRmA41TZYoFgcAzvEx5PHvb0yKIxEu8UBQuLVxeTmeqYMlLEXEEOyyl
	 lQBSzntnI0jm+AzrSiHMeweoUnrO2FlIIh0fZHmOMfad9MpfU/AH5iOExtev0V/26NrWG
	 IsaxnEBFOrfr/cZssavUFFXgxYvwAkgviDIvaOW6XewCTEfaJnuIXShHh5193SkOlYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169573;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=chkhcdX6Bzs6bDNeIMCt1PhEJl/8t7O6gom35b8Lz6A=;
	b=c3KoNpeil7ouIQH2FDIqCxmcX5NX0w1IH3IpOJfmWGgWvCMgjbIUUpK2VBvQyDztB/+H
	 +sebk1o6KixgljMeyyBvWFiDWhcVdR4QYh2RJB9ssZSd9kQFEKwoaPMmFY3zFrMB6gPDn
	 GR3qK0qmVhrqW4z+O0erOlqhhDeSGblQSRSNfXVxhhYxtHq62z9NA/JJhQ4VcY0HI+6sj
	 MxnmdrVOkM1N+lBKCbto+rJrgn2mexriYf3YcNDYbFKQE6nCMArQxUWn6if+pdTmXysps
	 xfnO67h8oGF0uVRUdeIW/M2aeVFhcJC1RUjhXKvx+Ey1YSb5C+BIp+LZZBYlWoims3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qUR9VgQt;
	arc=none smtp.remote-ip=91.218.175.198
Received: from mta0.migadu.com (out-198.mta0.migadu.com [91.218.175.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08760A2601
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E08760A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qUR9VgQt
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=StaXluOMaPjpZV2iR4wW4N7xxJTRw3M9e6DSzkM/2cA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795169570; v=1; x=1795774370;
 b=qUR9VgQt5vunHGpHs4jbYAnrgIlh+mJ74+a66KbjDSF+xRVuYpq1FxdV592CsO+4jiuLF2qp
 i7/sPtBa42pzydOt1EhGqbBg0DYOndjy7vusYK4wyUblmvwqUr2I9fokwrfU1hqburx49WeoebJ
 Zs3J0TalvmcAWpjJvGPQl52E=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id db2afc0d12127f3a;
	Fri, 20 Nov 2026 10:12:50 +0000
X-Mizu-Trace-ID: db2afc0d12127f3a
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 11:12:19 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 6/8] riscv: efi: Allow ACPI boots
Message-ID: <awAcbTDDUt5-g9YD@orel>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
 <20261105082035.133680-7-wangxiang@iscas.ac.cn>
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
In-Reply-To: <20261105082035.133680-7-wangxiang@iscas.ac.cn>

On Thu, Nov 05, 2026 at 04:20:33PM +0800, Xiang W wrote:
> riscv/efi/run rejected EFI_USE_ACPI=y because CPU, timer and ISA
> discovery aborted without a DT. Those paths can now walk MADT and
> RHCT, so drop the early exit.
> 
> The existing runner already omits -machine acpi=off when

s/omits/adds/

> EFI_USE_ACPI!=y. QEMU virt defaults to ACPI enabled, so no extra
> acpi=on flag is required. DT boots are unchanged: they still pass
> acpi=off.
> 
> Tested with:
> 
>   EFI_USE_ACPI=y EFI_UEFI=/path/to/RISCV_VIRT_CODE.fd \
>     ./riscv/efi/run riscv/riscv-brs.efi
> 
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> ---
>  riscv/efi/run | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/riscv/efi/run b/riscv/efi/run
> index b9b75440..a53b3a2c 100755
> --- a/riscv/efi/run
> +++ b/riscv/efi/run
> @@ -39,11 +39,6 @@ if [ ! -f "$EFI_UEFI" ]; then
>  	exit 2
>  fi
>  
> -if [ "$EFI_USE_ACPI" = "y" ]; then
> -	echo "ACPI not available"
> -	exit 2
> -fi
> -
>  # Remove the TEST_CASE from $@
>  shift 1
>  
> -- 
> 2.47.3
> 
