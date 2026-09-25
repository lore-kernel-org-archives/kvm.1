Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23B4D09FB
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350495; cv=pass; b=F1eh0QEitjCCNmTPjns1yG/829cHxjhgzh7PkniqNpA0a2i4o15Q7AgRTuC6CZj98ISYVagA9A46Gg8sBKBkTneyOWXMCrUGr5aF1CAK4RFD8ZC+f07cjXgvfQkNmQ2DjyfNOVoscngdvZkKrXJ2CCgaoVuAH9nfDJqiwMf66G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350495; c=relaxed/simple;
	bh=c4skHotUrohj5tY649YiUgljNI4R9MsOmUhNsuTt4mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+1bGGQhlWI3b+CdB1JumuopcNyvzpswmbXijTtUx2/wRsRvZnZzm9bcuGMCZI59DIgGSz5BkL0/wOwLl0QtUUfG+0lt/KVO/ZYaRxRQ2tjDpjgy/jCv1wFqvhNftSGWKI7sfRhr0+uV+oi/kJZSQd+sMOBrUfbrghdshr3VNL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1MyTIQn; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1MyTIQn"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1b846so1196669e87.0
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 08:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790350490; cv=none;
        d=google.com; s=arc-20260327;
        b=eILi2mYwVSsLXiKsleM1eqPh15dgZxEjDk6P4FVxDfgCt+xJmaLF2f+LQvwUAz5TIj
         D+WIKO9GB9B0AfhL8V8p1WpOgQgL1oVqFj47LhGM8/1v5n92Is/B+ioN50j7aNivI3/0
         xgkxIzr8vkuua2tOQt3qM2Zb5vPbUKzI0A1pOWgkt1SLNU7h4b5SvJ+zXJSBr4Qd01bL
         yqr7IdSK0MWCaVpbXThWd2r9VCtfbQcBBfTR83kafORWzeDGDuM91y/075EXGKZcSH9+
         NoLftjjCfTemIwtdZP/auGv46HgUIcAL7ONDvDuw/JSqGNSFj0SmlhcDjQ4g3AIAAGDy
         b7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LvgREEEhLtnlSAa2TqV+iSmo5cysotPSfNcR8BHubB4=;
        fh=oJzYtbghKNLyG26vpYZVJSP/4n+biZdDskWg9Fhkt9g=;
        b=Sfjra55iD0Bqa5oH/U0aIo6uxHyDzUQGYM/FGs3LRQWwYhtYR7nlf47MLZOSZ8IdOf
         rD7srSzDyZ82Ank/X2sTDzyNrpV+SxLdeV+OKv2Ixc6vZv3RzNA5YS9oKm2b8hok+Ne+
         lLaRud7HQc6+pRLtsY/IOtjrmUoQ+6wA9nbBAxYsWOmQ6Wja9x7ixWoes/DMS/BH3w+u
         asUFJegS8qcju+cGO7IA8Ld14a32v6RSYdveOLEK6WJcXW6HvzNDJTI6yIeMk1QFrwKo
         jpbIxKtFVbmO9GMcV/12nobl2gPrvIdmaSUlb4Cf4bdeq1hJpIFJqhfSHOpexdgw1Vf6
         ddqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790350490; x=1790955290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LvgREEEhLtnlSAa2TqV+iSmo5cysotPSfNcR8BHubB4=;
        b=O1MyTIQnzOyM27E9q6b9rXtmkvc+s0IFHz1fOicCZf9QMnCGE0SuUbofcAyMnnZPqf
         mwQr06NaG0OIitVLmOfFTgD8QE3Ull+234CKemM0td5PZIaUa9rv7Mf/aaMT3j9mLLmD
         hgmY5jcPFosd+WNio7fBSi/DESSYRkiM8d1W94Jca9GEqljNQqn+D3fxr91B2r6jQ2ip
         wZliHo9q+DUW5Md7c2SXIQOOJOf2eudtLlkoqy9g9OPuwHgZM5BiI7qHpC/RO9UoT+me
         SlBvs6OdgHK7Ylck7eBNye6uy1wXfcFgcYQFHCyP2afH/UltMNwHYmhaJy8QIki7mM8X
         NGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350490; x=1790955290;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvgREEEhLtnlSAa2TqV+iSmo5cysotPSfNcR8BHubB4=;
        b=Uw1ZMYvfj681zsdxEwYpnnr4cENa3nupz0/SMej0OQ5sPN8D/dcwYiUFlmGew0anzf
         nrAYQKMJtaoIUFQC6NIdFnJqEenik5DoyiYSShSzbCbEZaPf+LLseJiEIZMCBUrpwxBc
         eNyzLPXb4XwfDynaM3OO+oDqXIZk0DtgmHLv4K6/okYaxGBu4rUuxGsQZUWDj1Zful6i
         s7IG3dfhsS4xGam9d0wBnLDuErYxL2h7PufBMTImwwqNsOrPj3DAk+4nHXUv2tKivtgd
         3A9srNJi20l+TH9+sQEg2rars/DQNDFcXpGy7/VU6gOmGzZgqkHfea47Ayj0JlT0vIhV
         Ehbg==
X-Forwarded-Encrypted: i=1; AKwUvBwDW4XTXhE4PjETq8X2+heiKQaKdRxSEY041OH+0FkO1LgdNr9tbpN4ceePI6sX/EovqwA=@vger.kernel.org
X-Gm-Message-State: AFuF++mL592feXZIYPuGFQCBohJueHXiA7ivF2tVhH1uVTwhWep2zogx
	awVtf+HefbBALFv968uZjdYCv0l7kU4W8OGUogihkDpexRKquHPGOfGvTijnLBrIW9thawWO2rQ
	4HbOP6VNzAjFiMZTAoVUdIwosykFz/gabbfiK8s1H
X-Gm-Gg: AYBFou1/P2+twPc1t1sKf4CR3Kl5h7QWHTqpbKyTkUjgOpYHRx3JXDLoyvrMGFbPy4G
	6+2D9xpd4XAfWjo0+WA/BGvXrkoWZIcjTfRSb05L1ZHFpMTFdoRf5AGlSEOXiKQpavqit/2yOKZ
	jYzfrGed6eWssiYuVTt9vDVSVVWd4y8y+PCbXgDqThZuLHrq4qGddSMKS7Lu+k/+PDCUqT+OeUQ
	EdxRUHK0nyA31m+ttZooDysx+/VsVUvk2hFrfqrHMArLjvQ6K8dUbSIwhCW70V3d4B7w4YYCURF
	LjH1hZsOxEuwboeqLRYpToAxOlLg92rNV9GASJzYYKv0+4hA6IkkHQ==
X-Received: by 2002:a05:6512:118c:b0:5b7:5142:d495 with SMTP id
 2adb3069b0e04-5b8df085af7mr1904494e87.64.1790350489353; Fri, 25 Sep 2026
 08:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924135201.850038-1-suzuki.poulose@arm.com>
 <20260924135201.850038-6-suzuki.poulose@arm.com> <arZmXFw5Jw2IbAmA@arm.com> <a11aba04-eaaa-43fd-988b-a2581b1b2fdb@arm.com>
In-Reply-To: <a11aba04-eaaa-43fd-988b-a2581b1b2fdb@arm.com>
From: Alper Gun <alpergun@google.com>
Date: Fri, 25 Sep 2026 08:34:37 -0700
X-Gm-Features: AclHuK8ZdVRdb_V4naZFOsXJSH2Fz3e3v_5J12YbiSGiHDcQI7elXhO9Nk5iNy0
Message-ID: <CABpDEu=Dmo6+KpkYwRwYyCWtKjazJvTktVQh6d+2sUM3AchHbg@mail.gmail.com>
Subject: Re: [PATCH v19 5/7] firmware: arm_rmm: Activate the RMM
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	maz@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com, 
	linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com, 
	sdonthineni@nvidia.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:02=E2=80=AFAM Suzuki K Poulose <suzuki.poulose@ar=
m.com> wrote:
[...]
> Kdump may be a bit more easier, as the kdump kernel is supposed to use
> the "reserved" region and vmcore access could handle the GPF and
> provide "0"s to the reader ? May be this is one case where the
> host needs to be able to handle GPFs.

I've tested kdump on CCA hardware with a running Realm VM and hit
GPF 0x28 in copy_oldmem_page() when reading pages delegated for
RMM/Realm metadata.
Since do_gpf() already runs fixup_exception(), using
copy_from_kernel_nofault() and falling back to iov_iter_zero() in
copy_oldmem_page() fixes it.

Here is the fix I've tested for the v16 CCA series.


diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.=
c
index 670e4ce81822..b0ab22293aa9 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -6,16 +6,28 @@
  * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  */

+#include <linux/cpufeature.h>
 #include <linux/crash_dump.h>
 #include <linux/errno.h>
+#include <linux/gfp.h>
 #include <linux/io.h>
+#include <linux/uaccess.h>
 #include <linux/uio.h>
 #include <asm/memory.h>

+static bool system_has_rme(void)
+{
+ u64 pfr0 =3D read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+
+ return cpuid_feature_extract_unsigned_field(pfr0,
+    ID_AA64PFR0_EL1_RME_SHIFT);
+}
+
 ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
  size_t csize, unsigned long offset)
 {
  void *vaddr;
+ void *buf;

  if (!csize)
  return 0;
@@ -24,8 +36,31 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
unsigned long pfn,
  if (!vaddr)
  return -ENOMEM;

- csize =3D copy_to_iter(vaddr + offset, csize, iter);
+ if (!system_has_rme()) {
+ csize =3D copy_to_iter(vaddr + offset, csize, iter);
+ memunmap(vaddr);
+ return csize;
+ }
+
+ buf =3D (void *)__get_free_page(GFP_KERNEL);
+ if (!buf) {
+ memunmap(vaddr);
+ return -ENOMEM;
+ }
+
+ /*
+ * Pages delegated to the Realm Management Monitor (RMM) or Root
+ * world trigger a synchronous Granule Protection Fault (GPF) when
+ * read from the Non-Secure crash kernel. Use copy_from_kernel_nofault()
+ * so the exception table catches the GPF and fall back to zero-filling
+ * the inaccessible granule.
+ */
+ if (copy_from_kernel_nofault(buf, vaddr + offset, csize))
+ csize =3D iov_iter_zero(csize, iter);
+ else
+ csize =3D copy_to_iter(buf, csize, iter);

+ free_page((unsigned long)buf);
  memunmap(vaddr);

  return csize;
