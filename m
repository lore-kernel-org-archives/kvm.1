Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D44AA418;
	Tue, 13 Oct 2026 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917672; cv=none; b=OG75B3Gc8lYGKTrlD1kHkDZdry/MUXu5Rk3TRQPsWjh+YCeU2W1rZNRkIPfkt7k3k9F2+Q3RNGxNPN2KnQlmfTIW95tpzzXusnrIWaifhwrPs0Omdm7eQNoH9qhDyiy2BnAyU51jcqPVPyZxyGhCpjQp3p9WtEKDmLWhKjytNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917672; c=relaxed/simple;
	bh=YFp+jFsa7KANQNnGGNEj69jjzzJF2NN4Y6hPFMQdVbw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=g4K0EzbMgOpY/mekLwOYXtAgA0gBiNpHeDhUAhJgmZW685LFGHBHkIqG3mIIfJSIY8QuGXBMfQR6IeTuDvagacjdxLANdjmolzns2E5ZwYmOs2ZpSxpML2Rxhub7X4ZGZIryYde1Czis0cIw7j36TVYP6WbctiZS80dJ+8w+pFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Xz9M4NYP; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Xz9M4NYP"
Received: from [IPV6:2601:646:8003:f231:356f:4b4f:2ec9:d15a] ([IPv6:2601:646:8003:f231:356f:4b4f:2ec9:d15a])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69DIs5Ov3401961
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 13 Oct 2026 11:54:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69DIs5Ov3401961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1791917646;
	bh=oYmpP+4TITEiCyfQDXkqoB/XLVHuxWmAeDx4l6PscqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xz9M4NYPsu3fVJkRyYCyktAzLRTEL3VhDNsbfzcQA9Ffq6l0fl5CEWy3+BuFIz0wi
	 QvoNYMPiePMGenUxlzEp8VnEFL6dJptYXgtShd5X3+TaYIvRTywUejTBDQOFgCDJpE
	 4IHgzAY3Bb7IQU0IqYiCxWxiBhZhZRRanyYWBBdn8MEGQJ2HL2BAeHWSBHhWjtOmwi
	 9i8PTm4oBqchowiLwLXQLbYRm7QbuQ8NFkuBkMcyvwHK16Pbu1c4CwOQUhy8gA+rXp
	 gcVLWlPj1N6Vt4rEPYWMbXzcqF9acHxbWHalvG1sTbkt3vfZ3URTVE15vjgLbyzPmQ
	 8QC/vEToBdc0g==
Content-Type: multipart/mixed; boundary="------------fEc5ZnJrVUT2KPrkUgG4qgrt"
Message-ID: <b6cee0b8-c5cf-4136-928f-96cb0a58eaa3@zytor.com>
Date: Tue, 13 Oct 2026 11:54:00 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/x86: Add a test for LASS enforcement
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Kishen Maloor <kishen.maloor@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261009020025.4175228-1-sohil.mehta@intel.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20261009020025.4175228-1-sohil.mehta@intel.com>

This is a multi-part message in MIME format.
--------------fEc5ZnJrVUT2KPrkUgG4qgrt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-10-08 19:00, Sohil Mehta wrote:
> 
> Note, the CPUID bit does not reflect whether the kernel enabled LASS;
> only the cpuinfo flag does. But parsing cpuinfo is cumbersome, and the
> kernel enables LASS whenever the CPU supports it unless the command line
> opts out (vsyscall=emulate or clearcpuid=lass). To keep it simple, rely
> on the CPUID bit and accept a failure in these unusual cases.
> 
Cumbersome, really?

Here is a set of parsing functions -- tested, even! -- that you can make
available as library routines. Integrating them into the selftests build
framework has been left as an exercise for the reader ;-)

Signed-off-by: H. Peter Anvin (Rosaic) <hpa@zytor.com>

	-hpa

--------------fEc5ZnJrVUT2KPrkUgG4qgrt
Content-Type: text/x-csrc; charset=UTF-8; name="cpuinfo.c"
Content-Disposition: attachment; filename="cpuinfo.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3RkbGli
Lmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKI2RlZmluZSBs
aWtlbHkoeCkJX19idWlsdGluX2V4cGVjdCghISh4KSwgMSkKI2RlZmluZSB1bmxpa2VseSh4
KQlfX2J1aWx0aW5fZXhwZWN0KCEhKHgpLCAwKQoKc3RhdGljIGNoYXIgKnJlYWRfY3B1aW5m
byh2b2lkKQp7Cgljb25zdCBzaXplX3QgYnVmc3RlcCA9IDY0KjEwMjQ7CglzaXplX3QgYnVm
c2l6ZSA9IDA7CglzaXplX3QgbGVuID0gMDsKCXNzaXplX3QgcmxlbjsKCWNoYXIgKmJ1ZiA9
IE5VTEw7CgljaGFyICpuZXdidWY7CglpbnQgZmQ7CglpbnQgZXJyOwoJY2hhciAqcDsKCglm
ZCA9IG9wZW4oIi9wcm9jL2NwdWluZm8iLCBPX1JET05MWSk7CglpZiAoZmQgPCAwKQoJCXJl
dHVybiBOVUxMOwoKCWRvIHsKCQlpZiAobGVuID49IGJ1ZnNpemUpIHsKCQkJYnVmc2l6ZSAr
PSBidWZzdGVwOwoJCQluZXdidWYgPSByZWFsbG9jKGJ1ZiwgYnVmc2l6ZSk7CgkJCWlmICgh
bmV3YnVmKQoJCQkJZ290byBlcnJvcjsKCQkJYnVmID0gbmV3YnVmOwoJCX0KCgkJcmxlbiA9
IHJlYWQoZmQsIGJ1ZiArIGxlbiwgYnVmc2l6ZSAtIGxlbik7CgkJaWYgKHJsZW4gPCAwKSB7
CgkJCWlmIChlcnJubyA9PSBFSU5UUiB8fCBlcnJubyA9PSBFQUdBSU4pCgkJCQljb250aW51
ZTsKCQkJZWxzZQoJCQkJZ290byBlcnJvcjsKCQl9CgoJCWxlbiArPSBybGVuOwoJfSB3aGls
ZSAocmxlbik7CgoJLyoKCSAqIFRoZXJlIHNob3VsZCBhbHdheXMgYmUgYSBibGFuayBsaW5l
IGFmdGVyIGVhY2ggQ1BVLAoJICogaW5jbHVkaW5nIGF0IHRoZSBlbmQuCgkgKi8KCWlmIChs
ZW4gPCAyIHx8IG1lbWNtcChidWYgKyBsZW4gLSAyLCAiXG5cbiIsIDIpKSB7CgkJZXJybm8g
PSBFUFJPVE87CgkJZ290byBlcnJvcjsKCX0KCgljbG9zZShmZCk7CgoJLyoKCSAqIGJ1ZiB3
aWxsIGhhdmUgYXQgbGVhc3Qgb25lIGZyZWUgYnl0ZSBhdCB0aGUgZW5kLiBBcyBhIHJlc3Vs
dDoKCSAqIC0gRWFjaCBwcm9jZXNzb3IgZGF0YSBibG9jayBpcyB0ZXJtaW5hdGVkIGJ5IGFu
IGVtcHR5IHN0cmluZy4KCSAqIC0gVGhlIGVudGlyZSBmaWxlIGlzIHRlcm1pbmF0ZWQgYnkg
dHdvIGVtcHR5IHN0cmluZ3MgaW4gYSByb3cuCgkgKi8KCWJ1ZltsZW5dID0gJ1wwJzsKCgkv
KiBNYWtlIGVhY2ggbGluZSBhIHNlcGFyYXRlIHN0cmluZyAqLwoJZm9yIChwID0gYnVmOyBw
IDwgYnVmICsgbGVuOyBwKyspIHsKCQlpZiAoKnAgPT0gJ1xuJykKCQkJKnAgPSAnXDAnOwoJ
fQoKCW5ld2J1ZiA9IHJlYWxsb2MoYnVmLCBsZW4rMSk7CglpZiAobmV3YnVmKQoJCWJ1ZiA9
IG5ld2J1ZjsKCglyZXR1cm4gYnVmOwoKZXJyb3I6CgllcnIgPSBlcnJubzsKCWNsb3NlKGZk
KTsKCWZyZWUoYnVmKTsKCWVycm5vID0gZXJyOwoJcmV0dXJuIE5VTEw7Cn0KCmNvbnN0IGNo
YXIgKmdldF9jcHVpbmZvKHZvaWQpCnsKCXN0YXRpYyBjaGFyICpjcHVpbmZvOwoKCWlmICh1
bmxpa2VseSghY3B1aW5mbykpCgkJY3B1aW5mbyA9IHJlYWRfY3B1aW5mbygpOwoKCXJldHVy
biBjcHVpbmZvOwp9CgovKgogKiBTZXRzICp2YWx1ZSB0byB0aGUgY29udGVudHMgb2YgdGhl
IGZpZWxkIGZvciBhIHNwZWNpZmljIENQVSBvciBOVUxMLgogKiBSZXR1cm5zIDAgb24gc3Vj
Y2VzcyBvcjoKICoJLWVycm5vCS0gYW55IGZpbGUgSS9PIGVycm9yCiAqCS1FUFJPVE8JLSBw
YXJzaW5nIGVycm9yCiAqCS1FU1JDSAktIG5vIHN1Y2ggQ1BVCiAqCS1FTk9NU0cJLSBubyBz
dWNoIHRhZwogKi8KaW50IGNwdWluZm9fZ2V0X2ZpZWxkKGNvbnN0IGNoYXIgKip2YWx1ZSwg
Y29uc3QgY2hhciAqZmllbGQsIHVuc2lnbmVkIGxvbmcgY3B1KQp7CglzdGF0aWMgY29uc3Qg
Y2hhciBwcm9jZXNzb3JfcHJlZml4W10gPSAicHJvY2Vzc29yXHQ6ICI7Cgljb25zdCBzaXpl
X3QgcGZ4bGVuID0gc2l6ZW9mIHByb2Nlc3Nvcl9wcmVmaXggLSAxOwoJc2l6ZV90IGZpZWxk
bGVuOwoJY29uc3QgY2hhciAqcDsKCgkqdmFsdWUgPSBOVUxMOwoJcCA9IGdldF9jcHVpbmZv
KCk7CglpZiAoIXApCgkJcmV0dXJuIC1lcnJubzsKCgl3aGlsZSAoMSkgewoJCS8qIEJsYW5r
IGxpbmUgYXQgc3RhcnQgLT4gbm8gbW9yZSBwcm9jZXNzb3JzICovCgkJaWYgKCEqcCkKCQkJ
cmV0dXJuIC1FU1JDSDsKCgkJLyogRmlyc3QgbGluZSBtdXN0IGJlIHByb2Nlc3NvciAqLwoJ
CWlmIChzdHJuY21wKHAsIHByb2Nlc3Nvcl9wcmVmaXgsIHBmeGxlbikpCgkJCXJldHVybiAt
RVBST1RPOwoKCQlpZiAoc3RydG91bChwICsgcGZ4bGVuLCBOVUxMLCAxMCkgPT0gY3B1KQoJ
CQlicmVhazsJLyogRm91bmQgb3VyIENQVSAqLwoKCQkvKgoJCSAqIFNraXAgdG8gdGhlIG5l
eHQgcHJvY2Vzc29yLgoJCSAqIEVhY2ggcHJvY2Vzc29yIGJsb2NrIGlzIHRlcm1pbmF0ZWQg
YnkgYSBibGFuayBsaW5lLgoJCSAqLwoJCWRvIHsKCQkJcCA9IHN0cmNocihwLCAnXDAnKSAr
IDE7CgkJfSB3aGlsZSAoKnApOwoJCXArKzsJCS8qIFNraXAgdGhlIGJsYW5rIGxpbmUgKi8K
CX0KCgkvKiBMb29rIGZvciB0aGUgcmVxdWVzdGVkIGZpZWxkIGluc2lkZSB0aGUgcHJvY2Vz
c29yIGJsb2NrLiAqLwoJZmllbGRsZW4gPSBzdHJsZW4oZmllbGQpOwoKCXdoaWxlICgqcCkg
ewoJCWlmICghc3RybmNtcChwLCBmaWVsZCwgZmllbGRsZW4pKSB7CgkJCXAgKz0gZmllbGRs
ZW47CgkJCWlmICghKnApCgkJCQlyZXR1cm4gLUVQUk9UTzsgLyogTm8gZmllbGQgZGF0YSBw
cmVzZW50ICovCgoJCQlpZiAoKnAgPT0gJ1x0JyB8fCAqcCA9PSAnOicpIHsKCQkJCS8qIEZp
ZWxkIG1hdGNoZXMgKi8KCgkJCQl3aGlsZSAoKnAgPT0gJ1x0JykKCQkJCQlwKys7CgkJCQlp
ZiAoKnAgIT0gJzonKQoJCQkJCXJldHVybiAtRVBST1RPOyAvKiBDb2xvbiBtaXNzaW5nICov
CgkJCQlwKys7CgoJCQkJLyogU2tpcCBzcGFjZSBhZnRlciBjb2xvbiAqLwoJCQkJaWYgKCpw
ID09ICcgJykKCQkJCQlwKys7CgkJCQkqdmFsdWUgPSBwOwoJCQkJcmV0dXJuIDA7CQkvKiBG
aWVsZCBmb3VuZCAqLwoJCQl9CgkJfQoJCXAgPSBzdHJjaHIocCwgJ1wwJykgKyAxOwkvKiBO
ZXh0IGZpZWxkICovCgl9CgoJcmV0dXJuIC1FTk9NU0c7CQkvKiBDUFUgZm91bmQgYnV0IG5v
IHN1Y2ggZmllbGQgKi8KfQoKLyoKICogTG9vayBmb3IgYSBzcGVjaWZpYyBmbGFnIGluc2lk
ZSBhIHNwZWNpZmljIG11bHRpLXRva2VuIGZpZWxkOwogKiB0aGlzIGN1cnJlbnRseSBhcHBs
aWVzIHRvIHRoZSAiZmxhZ3MiIG9yICJidWdzIiBmaWVsZHMuCiAqCiAqIFJldHVybiAxIGlm
IHRoZSBnaXZlbiBmbGFnIGlzIHByZXNlbnQsIDAgaWYgaXQgaXMgbm90LCBvcgogKiBhIG5l
Z2F0aXZlIGVycm9yIGNvZGUgcmV0dXJuZWQgZnJvbSBjcHVpbmZvX2dldF9maWVsZCgpLgog
Ki8KaW50IGNwdWluZm9faGFzX2ZsYWcoY29uc3QgY2hhciAqZmxhZywgY29uc3QgY2hhciAq
ZmllbGQsIHVuc2lnbmVkIGxvbmcgY3B1KQp7Cgljb25zdCBjaGFyICpwOwoJc2l6ZV90IGZs
YWdsZW47CglpbnQgZXJyOwoKCWVyciA9IGNwdWluZm9fZ2V0X2ZpZWxkKCZwLCBmaWVsZCwg
Y3B1KTsKCWlmIChlcnIpCgkJcmV0dXJuIGVycjsKCglmbGFnbGVuID0gc3RybGVuKGZsYWcp
OwoJd2hpbGUgKCpwKSB7CgkJaWYgKCFzdHJuY21wKHAsIGZsYWcsIGZsYWdsZW4pICYmCgkJ
ICAgICghcFtmbGFnbGVuXSB8fCBwW2ZsYWdsZW5dID09ICcgJykpCgkJICAgIHJldHVybiAx
OwkvKiBGbGFnIGZvdW5kICovCgoJCS8qIFNraXAgdG8gdGhlIG5leHQgZmxhZyAqLwoJCXAg
PSBzdHJjaHIocCwgJyAnKTsKCQlpZiAoIXApCgkJCWJyZWFrOwoJCXArKzsKCX0KCglyZXR1
cm4gMDsJCS8qIE5vdCBmb3VuZCAqLwp9CgojaWZkZWYgVEVTVF9DUFVJTkZPCgojaW5jbHVk
ZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN5c2V4aXRzLmg+CgppbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpCnsKCWNvbnN0IGNoYXIgKmZpZWxkLCAqZmxhZzsKCXVuc2lnbmVkIGxv
bmcgY3B1OwoJaW50IHJ2OwoKCWlmIChhcmdjIDwgMykgewoJCWZwcmludGYoc3RkZXJyLCAi
VXNhZ2U6ICVzIGNwdSBmaWVsZFxuIiwgYXJndlswXSk7CgkJZXhpdChFWF9VU0FHRSk7Cgl9
CgoJY3B1ID0gc3RydG91bChhcmd2WzFdLCBOVUxMLCAxMCk7CglmaWVsZCA9IGFyZ3ZbMl07
CglmbGFnID0gYXJndlszXTsKCglpZiAoZmxhZykgewoJCXJ2ID0gY3B1aW5mb19oYXNfZmxh
ZyhmbGFnLCBmaWVsZCwgY3B1KTsKCQlpZiAocnYgPj0gMCkgewoJCQlwcmludGYoIkNQVSAl
bHUgJXMoJXMpID0gJWRcbiIsIGNwdSwgZmllbGQsIGZsYWcsIHJ2KTsKCQkJZXhpdChydik7
CgkJfQoJfSBlbHNlIHsKCQljb25zdCBjaGFyICpkYXRhOwoJCXJ2ID0gY3B1aW5mb19nZXRf
ZmllbGQoJmRhdGEsIGZpZWxkLCBjcHUpOwoJCWlmICghcnYpIHsKCQkJcHJpbnRmKCJDUFUg
JWx1ICVzID0gJXNcbiIsIGNwdSwgZmllbGQsIGRhdGEpOwoJCQlleGl0KDApOwoJCX0KCX0K
CgkvKgoJICogT24gZXJyb3IuIEVycm9ycyB0aGF0IHNob3VsZCBuZXZlciBoYXBwZW4gbm8g
bWF0dGVyIHdoYXQgdGhlCgkgKiBpbnB1dCBhcmUgc2VudCB0byBzdGRlcnIuCgkgKi8KCXN3
aXRjaCAocnYpIHsKCWNhc2UgLUVTUkNIOgoJCXByaW50ZigiQ1BVICVsdSBkb2VzIG5vdCBl
eGlzdFxuIiwgY3B1KTsKCQlleGl0KEVYX05PVVNFUik7CgljYXNlIC1FTk9NU0c6CgkJcHJp
bnRmKCJDUFUgJWx1ICVzIDogZmllbGQgZG9lcyBub3QgZXhpc3RcbiIsIGNwdSwgZmllbGQp
OwoJCWV4aXQoRVhfTk9JTlBVVCk7CgljYXNlIC1FUFJPVE86CgkJZnByaW50ZihzdGRlcnIs
ICIlczogY291bGQgbm90IHBhcnNlIC9wcm9jL2NwdWluZm9cbiIsIGFyZ3ZbMF0pOwoJCWV4
aXQoRVhfUFJPVE9DT0wpOwoJZGVmYXVsdDoKCQlmcHJpbnRmKHN0ZGVyciwgIi9wcm9jL2Nw
dWluZm86ICVzXG4iLCBzdHJlcnJvcigtcnYpKTsKCQlleGl0KEVYX09TRklMRSk7Cgl9Cn0K
CiNlbmRpZiAvKiBURVNUX0NQVUlORk8gKi8K

--------------fEc5ZnJrVUT2KPrkUgG4qgrt--
