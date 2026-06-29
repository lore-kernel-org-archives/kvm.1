Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE61426EA0
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745546; cv=pass; b=BaXBhC55S3PwA4k2nA6OljqDf886uAvnrVx4WvTaTTonEhNaVkmwg1jzjOkcmUWY1cZ1IOycNl+DyNo2U3G+aPUre2qAaYOQTEPOysA/8K+fwuANiRC9C7JDOs8Bj6C+ZVN35g5xs8Oybg3cf+A/yGpNXdXK+o58py+jpspguTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745546; c=relaxed/simple;
	bh=XAAoNYSn/r3Ma8P8UYTG+xzlfsNSWQVIOqHGLCocNZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFZtkbUAkFizs7Y2u8fe/RBZZfPfZNC+x6WUE6apH6Tw6FSOzkiya5AU9dpWNhpt/2wvOJEVoTlenBIJgtjgxNPIQe0OMuGcUJzLfNlGzBH1G7RlWwq+n54iQYEmNGQp9CwbN8z79dJmXejbyrOrjvQG0NlUTJGmy6kvv6r+ZLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqTvzvQ+; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqTvzvQ+"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6981fefb9easo13153a12.1
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 08:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782745543; cv=none;
        d=google.com; s=arc-20260327;
        b=KHeUvNAReKmVDinCbhUOC+f45wTXbmxqYYmqK2+uP8QyuqJ0ubduqE4XPUUm6fAyjO
         6VzNoEtPI5Tie1t8FLTsnO8JFEoWMQGUMxSuqh7JPsVZv+xGNXXMz1r0HhVMPUo7lxTF
         KvQs+kvhean8d39cFPAk6m2dnkNAD8+v8RwjnQVOkRcD72FblG7t9Q1c8lPHv+Anvjwg
         gi3lSEYeygDrhT1XBOe3aycByrIPFs3LY2S6WXq086trPekwM4kCMf6jex5T8qgarb2T
         rZw3s510tlenpu17kf4F+TpsetsMuw4+s1QvnG4HAq0eoBtdf1uUx6vkG86eURxgGwHM
         7xIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kx6sIxZoXItf1W4sk9dkNdIelPfiZanaIqph2jO5EzU=;
        fh=coCxr276GfjzVAUHZoI87m/IwN8i/GLa81vFZaLfFPk=;
        b=D2zXXfqKIL6afH2p71KTMnhZZnxrnUaVeEqtt9l55un2z3ZZKqaRf5/41PC85Rx/rb
         4V8HkF8auTVkVUtGBV9HQCwxKpJH+1HDRqYBiTO5UF5vcvWNQt+GnkuSvayXQcYz4zGQ
         lOuncdhHle7pQSnQeIzU1TjptRG/3h6VwDABM1zJ/VzVg3pXb79uGQY1hEOI8gPvALD2
         JM1bErWhlQEN6XXwgl3cqrAEPgTx/56fmuf8b5bFQQEI7pleypT20wP4tYdficpyjR6+
         FksagISOzwhU90AB/wBNgsC+TD8BV3t6kdJpDKlgBAUNH24sFZUGx4WJBucS8TXdTYO9
         0dgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782745543; x=1783350343; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kx6sIxZoXItf1W4sk9dkNdIelPfiZanaIqph2jO5EzU=;
        b=DqTvzvQ+hY7qbDkzCNxRg+wZtIxMxkukgcpO8GHP8qxfmBEymNCMAvkov0utw7vKZo
         iORuJjnoKhdSDo7YZLN0Yji89gTNEY+NDBkdy+X0CGhOCidtagBacQz53pldLt2KlPH7
         XTl25adFsEfzbOamvZKiMrWh0KRZQZunpXhD/jTbS+eH9+6ALjAF5dp+GzBYItd3WJto
         C995kVL3+VPl2JhTfaM/pX4aUdsu3WfU3ivo8kp/+oZ4uiRZwTwUcokzsno7KBbGyVaz
         clLHzC9bL/+Ck9PYgOyaDor85NeXE/Q1PaLrx1a0/L24hfyAXrFfNw/Zp6RGC9wq8RFW
         V4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782745543; x=1783350343;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kx6sIxZoXItf1W4sk9dkNdIelPfiZanaIqph2jO5EzU=;
        b=Sx09Fbwu6jm9xMnWuFQivTyqWPjt4HE99Y9Oa7k9cEh6GDL7ZvWSWtoZZRUV3FHcfy
         lyrpeiCmxMiVjuD6ITyi1M+9vUYqKpN1FrxbOWsMPCmlwL6t3TeF//s131xNVZl3DGz6
         HMmHCksQ3hXhB33/xqKsLJh1GDYmFuHti4ZnvFv6KPej5qpgZ5CfKu2A+ySWxnrwbekt
         ICq885erI2xL94JWNZN/uy1TrIkDceJtGm/p1waHXlve6A/hibLEv/HPyfoWBAbsRzen
         6SnFz9WO/RnQapGZWDDTalNSW1ld7XHa3Zmb/wEPQO39064ReoAOnM8ahAv3tvK5tSGk
         nRDA==
X-Forwarded-Encrypted: i=1; AHgh+RpyBE/fQkp9/9qmfsDQMtxN+USQpGgYliX2aWVethZu9iGpm201VRBoMWnZ0mi6JLipXFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSfj+LVLUnN5Bcy/4lUvg+v+z7Bs+C1nKTTV3wg/TKpwFmVAVO
	1e4llibinCndwtdH3IfjXs+6eFQp8jl6vuw3zgeMQuFfgp/I6TZsHAhi/naFz10wM5X6fAIh8fM
	RGhC9c1jBqUUtsW2n4gW/ww6BUx18ikmjtCZcZDaB
X-Gm-Gg: AfdE7clxNqfW256momrBIVPGyyXNvFtDKWCJ4yKDdsmFEs/GgaRYn8Ggk26IhS1Zitr
	KJUmN2Yve9u7INDnZAjQ9G2X71OjchzK5uages5O7Y1p4MBev3tGKXqXorjO8id75Yj1Hvrtus3
	hOO3rScIP7AQuyRob/yaCkNYh+snTznxpkM0eGgQQuBjBk+Vc2WbnNwXTG0z1PE0NS0mAR73qKj
	SVIJrswjgmmMeNI/WH5Wok4PQQ3JQveOIX7kKLs5mzjhmr8Hgo0l3H22UY+ks+94o3h/bFgOQ==
X-Received: by 2002:a05:6402:424c:10b0:68a:83c2:9c75 with SMTP id
 4fb4d7f45d1cf-698795f58f5mr2358a12.0.1782745542255; Mon, 29 Jun 2026 08:05:42
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <akJ6Z2P8eMm1tc65@kernel.org> <CA+i-1C1CMgmPyqxT3dkLWVT34HqoPBi+0=GhF2rk2-wJSjSZng@mail.gmail.com>
In-Reply-To: <CA+i-1C1CMgmPyqxT3dkLWVT34HqoPBi+0=GhF2rk2-wJSjSZng@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 29 Jun 2026 17:05:30 +0200
X-Gm-Features: AVVi8CfvejoTQU8KXVTesjH-swbBnnggwErReWWIPfe5O_Cbw4Rt2EVNnoBtZLE
Message-ID: <CA+i-1C10zQs8sGtQpR+jsPsQVCO+Y9VRXkgt9xikxgc2eCFWVQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] mm: Some cleanups for page allocator APIs
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dimitris Michailidis <dmichail@fungible.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 at 16:30, Brendan Jackman <jackmanb@google.com> wrote:
>
> On Mon, 29 Jun 2026 at 16:00, Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi Brendan,
> >
> > On Mon, Jun 29, 2026 at 01:11:49PM +0000, Brendan Jackman wrote:
> > >
> > > Some tweaks and cleanups for page allocator entrypoint and flags. This
> > > is motivated by preparation for __GFP_UNMAPPED [1] (which will probably
> > > become ALLOC_UNMAPPED in its next iteration), but all this is supposed
> > > to be an improvement to the codebase in its own right: unifying code
> > > paths, reducing API surface, and removing GFP flags.
> > >
> > > Tested:
> > >
> > > - KVM, mm, and BPF selftests in a QEMU VM
> > >
> > > - kunit.py on x86_64
> > >
> > > - For the ALLOC_NO_CODETAG bits I just booted a VM and read
> > >   /proc/allocinfo. I confirmed that if I remove ALLOC_NO_CODETAG, the
> > >   kernel crashes in early boot, so I was at least booting code that
> > >   depends on this logic.
> >
> > Heads up before the full kbuild report:
> >
> > CI has tested the following submission:
> > Status:     FAILURE
> > Name:       [v3,00/16] mm: Some cleanups for page allocator APIs
> > Patchwork:  https://patchwork.kernel.org/project/linux-mm/list/?series=1118244&state=*
> > Matrix:     https://github.com/linux-mm/linux-mm/actions/runs/28375636866
>
> Agh, thanks, I broke the build for CMA.
>
> I thought I had this covered in my local test scripts. I will fix that
> first then I'll send a fixup for the patch.

OK my scripts are indeed checking CMA, the issue is that I didn't
build with NUMA_BALANCING.

I guess Suren was right[0] and I really should build allmodconfig (at
least vmlinux) before sending patches. I was a bit skeptical that this
was an especially useful config to build, but now I realise it just
maximises coverage, even if it does so under a pretty arbitrary
configuration.

[0] https://lore.kernel.org/all/CAJuCfpHAMaK2sZYSgS750CvgksCKEfOmLzZasXdBup+CrS-3Pg@mail.gmail.com/

Here are the fixes:

diff --git i/mm/migrate.c w/mm/migrate.c
index d9b23909d716c..8e0a6fb3f6618 100644
--- i/mm/migrate.c
+++ w/mm/migrate.c
@@ -49,6 +49,7 @@
 #include <trace/events/migrate.h>

 #include "internal.h"
+#include "page_alloc.h"
 #include "swap.h"

 static const struct movable_operations *offline_movable_ops;
diff --git i/mm/page_reporting.c w/mm/page_reporting.c
index 7418f2e500bb4..c7325704c3202 100644
--- i/mm/page_reporting.c
+++ w/mm/page_reporting.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/scatterlist.h>

+#include "page_alloc.h"
 #include "page_reporting.h"
 #include "internal.h"

diff --git i/mm/shuffle.c w/mm/shuffle.c
index fb1393b8b3a9d..82a2c7725a08a 100644
--- i/mm/shuffle.c
+++ w/mm/shuffle.c
@@ -7,6 +7,7 @@
 #include <linux/random.h>
 #include <linux/moduleparam.h>
 #include "internal.h"
+#include "page_alloc.h"
 #include "shuffle.h"

 DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
