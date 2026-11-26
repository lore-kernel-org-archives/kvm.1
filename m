Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708993;
	b=EMxLNVQgNbGO1LKoFzJAMWtb0RiyfoDyEC42dePrq+qsJq6kJ2IRGPs9Syli7ay+HqOg
	 l/lMCj6U3NfZegwab1hah+zLs1Auf+rxnV8L4s7NKfF1K0fAhZkJSdrRionH8E58R+/Tg
	 HFavEE+HSyD5DwzYOGcXjumOMaH3hcKDBAa7ghR03DqTeq11LFi/SHT+mjDK3yE6G4V0F
	 C860woGQlESSIYvlbVP0snpqe3eLap/ZMqJZLtacmDu0LDgd9y9njiOD+12djaU0vs3ws
	 AdubTAiMcgsh7R8U1Y4UzB3w2K3Y/gVKDIlrtYKqbasJV8YuW5lzILixrVfmumcCVFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708993;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7mNzc2aT/cA2HoMkbjyguJ+khJMad/YVpKxafKYQx0o=;
	b=MFr/motw8fLGOAuIXDGb5mmqbF+4cvqFc9PkivGU+vilWrGpWLTyQbbF+Pv1VKgdnE6k
	 Ybe3JCElaBs4FZ/CrioFqUNU4olw+CRmWUcPWxO0X2q+F8EqXl5Vedy7e4K5GkgMNfW+x
	 xX2ujzQFXgHhyfCS7t2xvlTy0DvQ0dyQ2n3Qp/yGofYBd+0RF9cEsX+by8Ud4TrxvXGu1
	 QYRJU5+4IBWZ4MxB6ngOxMgoVEgSyqzsvd7NO/hd8mTWWm5TzZ8xOuaO0Nfq5oL/aa7/K
	 xqHUUfHFbmlNU0dmvEzqlG8v84lu6Cc4EadelmRJn7cDL8HMPM3/p/kNnLwVCoQrlkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KPbzmaYb;
	arc=none smtp.remote-ip=91.218.175.44
Received: from mta0.migadu.com (out-44.mta0.migadu.com [91.218.175.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA8606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 16:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67DA8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KPbzmaYb
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=o9M6jya/dZBVHFqxl51VBiOONfDq+DicTW5T4wG0rZs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795708990; v=1; x=1796313790;
 b=KPbzmaYbm/AW3JvW36UQBr51OHLb41+tWDyyZoTEoHWUUckllWD39Vg35uIoG6QZTJOq0ccY
 KJXP0NLVSzJ+XIA6XgLFvTJIvE7Coev0lI5vKmKIAMTA5mU8m2jbXRmfLBpP+aQ79cFGWfxjk81
 ezyGPSyeVzUfm2Mh1O7KMrOU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 538b1557fc7b97c8;
	Thu, 26 Nov 2026 16:03:10 +0000
X-Mizu-Trace-ID: 538b1557fc7b97c8
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 17:02:29 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com
Subject: Re: [PATCH kvm-unit-tests 5/6] drop
 --enable/--disable-default-environ
Message-ID: <awhWnu2NEg_WrtRJ@orel>
References: <20261126103002.2145135-1-pbonzini@redhat.com>
 <20261126103002.2145135-6-pbonzini@redhat.com>
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
In-Reply-To: <20261126103002.2145135-6-pbonzini@redhat.com>

On Thu, Nov 26, 2026 at 11:30:01AM +0100, Paolo Bonzini wrote:
> I would be very surprised if anyone is using this option, which was
> probably meant to be used together with the errata system.  Keep
> the variable as it is used internally to prevent generation of an
> initrd, but drop it from ./configure.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure               | 11 -----------
>  scripts/arch-run.bash   |  2 ++
>  scripts/mkstandalone.sh |  1 -
>  3 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/configure b/configure
> index 7c9ebd49..9b325b54 100755
> --- a/configure
> +++ b/configure
> @@ -53,7 +53,6 @@ host=$arch
>  cross_prefix=
>  endian=""
>  pretty_print_stacks=yes
> -environ_default=yes
>  u32_long=
>  wa_divide=
>  target=
> @@ -97,9 +96,6 @@ usage() {
>  	    --endian=ENDIAN        endianness to compile for (little or big, ppc64 only)
>  	    --[enable|disable]-pretty-print-stacks
>  	                           enable or disable pretty stack printing (enabled by default)
> -	    --[enable|disable]-default-environ
> -	                           enable or disable the generation of a default environ when
> -	                           no environ is provided by the user (enabled by default)
>  	    --host-key-document=HOST_KEY_DOCUMENT
>  	                           Specify the machine-specific host-key document for creating
>  	                           a PVM image with 'genprotimg' (s390x only)
> @@ -189,12 +185,6 @@ while [[ $optno -le $argc ]]; do
>  	--disable-pretty-print-stacks)
>  	    pretty_print_stacks=no
>  	    ;;
> -	--enable-default-environ)
> -	    environ_default=yes
> -	    ;;
> -	--disable-default-environ)
> -	    environ_default=no
> -	    ;;

We're probably safe to remove them, but I can't recall if we've ever
removed configure parameters before. I'd probably conservatively keep
them as no-ops and document them as deprecated, since I think it might
be possible that people discovered --disable-default-environ, knew they
didn't want an environ, and then added that parameter to their
build/install/run scripts embedded deep in their test system.

Thanks,
drew
