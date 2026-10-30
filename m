Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353999;
	b=oGOEp3M7U7O26z02B2Wt3GHLjf2WAn2eLm/8ErWLJ/tQGP3xHkxGv51iKCAfJKOhdzbU
	 yN0Tf+h4R8tkZBEW9quEQcfXd6dpx/2fi2ChG7v+03JPl47cERHECs0wts9qfZgAZgvtg
	 hQWWqLjKzZpyf4uWijpcCmVjHm9Vm3JhAJD+wO1hckRl5s+lvw6nHto4bwgoP+Ppkwyjr
	 lq7iocvnV6B1EIkX9J1WTfsbRk0agK94y6kQ9X0L8LvdD1Q/dPvDh5JbkDVqymw/MuMv6
	 dzLO5I1oOufl0CvEFc90u67bEwBwZk8lidOQy55yvACfOhEewYpFg6A+uu312gHokUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2sVz2kekigEwFuAjOAkuOKnCrnayEOdl/QGk0rPw5eA=;
	b=NYIeSKUnlb1A23LQhyVev5907ckq7tQcQSnAO4P3OGgf/X8TRaSDUGUgFtMg9svwqfaD
	 9S65blpAWvPW/dK27PSz6ooxqt/q7R8/2Ml8Ef1J0siD9ElSKPw06plF9LuO8m/OWDKOJ
	 q9AUt/811BwkFgASZyFJJX9m41vluyA3+g8IB1kB89x+x67kkDaLYGyrWD3+kr+5rbHic
	 Cfp/6H9WlqxeG1C0Qd6p9lMwPtrV+fg2kTCTnXCGp4AQ68vVe2xdu4AcSGSa/A2pcGup5
	 /9Lx+xrbgDQYXz9QnU+/jkYNKALOSRtXq8pwmiavRad/QKLkCYUD3u4Daqm3hX27HlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=jfCUPK9s;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F960A2600
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 09:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 790F960A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=jfCUPK9s
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so5029335e9.2
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 02:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793353997; x=1793958797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2sVz2kekigEwFuAjOAkuOKnCrnayEOdl/QGk0rPw5eA=;
        b=jfCUPK9sZBoRtj2E+Alb9yXH9e9oEAKo6O5FdNMtEtjfbqrv2VRaYVXKp3gzMIsb45
         sd5OuL+bpBjiYZ5XwMFZwC4lARId+a+AiPW3kCH52zurleBtox0FUUeoLFox5UZbALIX
         iKhkw0WljBZZ7vq1pKhyJKVBXZVsAGRnFlj9YEJ71eTohu3oCRaJIaiPjZ+ONR0FrkN7
         9FWaY5PjdmumcBgOVAnQAZYOrvX2In4f41fMgf6TycYk0f0XDQq32zX+826jUXH5Tntc
         GM244THgeu1VuSeiZn0SWIzmXDYSOnmv4iLsdz10MK0iILCHIe5p/kNUpjENpypGm5IQ
         jgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353997; x=1793958797;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2sVz2kekigEwFuAjOAkuOKnCrnayEOdl/QGk0rPw5eA=;
        b=nE5KPgyaPHdAfghGpQ8KDgo2OJ/WkeZFg/abqiyHHlOmGX+vQUsAiZSYBL+w3LVJ06
         JePN525NOo0sPJxZp5u4astfT6xqnJ0/XefbzBzD6jjR7bwbm3aAB0Kq9XwKw7gJy3Nt
         X9NbbyoU/1Qh2dS42mJFo696GahXS5NW/Ue7bQzVjkV4ffG+E1bYXdGLClrwrrIEr/mn
         8yiVh+Yh9qkRkg7Nie2ODX+euxtcpV911TCv+YNLyANGg8UpHX5kiGFvilfs3fhk+Wiy
         SA0VhIWWvBYf7mI+Vk7iLQc9LaEI99HWjNIWmZfjemkEU28u+aeiRI+JidNKj50cGG1k
         yU1A==
X-Forwarded-Encrypted: i=1; AKwUvBwQsIO8sxWfENwTDl6YKL3M1yeBTCkU42XU3UmIQjRucOre53/2ndBH82vj/0CM91RgmsU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4Bxd7HOw2A6lwrrP7TJ1OtdI4/HN8K/emw85yxtq4tQxypvTh
	Tgsugtajk6T9hXOSalBsoPQJWXxBISFkYfYZdAflWOHfIM4eVZb3UpYLKnrKnxbQFjg=
X-Gm-Gg: AYBFou3/A67jKHxge3vje7ltpA5I0J/htSdbnvMUlC1z9BLx07neKxWSymhVXV53AUB
	1rBwcpZeq2c3euEOZj93uOvuB/YM91vDoyiAxs1dEPp73i+SRCPAlEQN+Ba763fqg24yT6zqH8F
	QQJ1yTqj6MH/olyBqe3ttfAcrI53+XUBESCV9ojqneted4Afo9o/gtGqiBAbY4RTva6Z473quMz
	QOiuUO/SVewI5lD/mE29Amb3A9h6iABJVZthQPW3K9ZJH9kmrdXY+JkENQPJ4zLHE1xlQVURkjK
	pQRFqifRjSNl767SVoKJqnK6fLaaWduXY1eeMEqBg4sJt9q4x1qqWWGQrM8rxIS125DKOKx7ZNx
	QLupFvkVFW37brIomQ4e2oo6fH5nka3VzHIFsFxg8Pcb6dL8T2CJcDsiYppU5aZH8mKSL42lb0a
	cosFN9nblGpZK9iY0Sf6venL1ZrPeDWstjxaDjMNVaCk06EjoXh8vfd+f7COG+drcq2+jVABZ7p
	p7LT+p3qGTs8uUArgGDQO0n9zlbyB73d9oACm3F3wyqArnApPrDZvNFT5uz1Ql7e+CtgcoQcQF4
	Viws+BvfqqyzUm9lDyji4SNIEtmDkJDu5sbP1iok6JD/x2tOJtGOSIZ2zDE=
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4ac18993ca7mr37419475e9.32.1793353996568;
        Fri, 30 Oct 2026 02:53:16 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04785sm127578065e9.4.2026.10.30.02.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:53:16 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:53:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 11/20] ctlv: Prepare runtime introspection
Message-ID: <auRmMPfaFINUIchi@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-12-jiri@resnulli.us>
 <179302367452.58760.11808905856343064399.b4-review@b4>
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
In-Reply-To: <179302367452.58760.11808905856343064399.b4-review@b4>

Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:

[..]

>
>This isn't even that complicated, if I ask AI to explain it in a C ish
>language:
>
>struct device_get_reply {
>	struct {
>		optional struct {
>			uint min_challenge_length;
>			uint max_challenge_length;
>			uint max_total_output_length;
>			struct {
>				enum blob_class;
>				string format;
>				enum representation;
>				uint max_length;
>			} objects[];
>		} evidence;
>
>		optional struct {
>			flags mr_flags; /* read, extend */
>		} mr;
>	} caps;
>
>	struct {
>		/* device-info: filled by the derived family */
>	} info;
>};
>
>I think the yaml names are not helping, calling everything attrs
>everywhere is really confusing. At least the transition into a nest
>and an attr-set should be more clearly marked in the yaml..
>
>The yaml would be significantly better if it was layed out according
>to the actual semantic flow instead of artificially being twisted into
>this need to put everything into a linear list. AI invented this:
>
>device-get:
>  request: {}
>  reply:
>    caps:
>      evidence?:
>        min-challenge-length: uint
>        max-challenge-length: uint
>        max-total-output-length: uint
>        objects[]:
>          blob-class: evidence-blob-class
>          format: string
>          representation: evidence-representation
>          max-length: uint
>      mr?:
>        mr-flags: mr-device-caps
>    info:
>      $extend: device-info
>

I have it implemented like this (with small changes). Looks great!


>So.. how about could we drop the sets, use a direct description of the
>layout and do something else for the ID numbering? Maybe the numbering
>can be solved directly by only listing the names in:
>
>numbering:
>  - device-get.reply
>  - device-get.reply.caps
>  - device-get.caps.evidence
>  -[..]
>
>?

I'm still committed to implicit numbering. For "inline records" I
resolved it by having it encoded as a tree with 4 levels:

 63         48 47 46 45        32 31  28 27  24 23  20 19  16 15               0
+-------------+-----+------------+------+------+------+------+------------------+
|   family    |kind |   index    |  L1  |  L2  |  L3  |  L4  |      field       |
+-------------+-----+------------+------+------+------+------+------------------+
              |<------------------ record ------------------>|

Renamed "attr" to "field" - I agree that the original implementation had
attr everywhere. I got rid of it.
"group" is now "record". I enlarged it to 32 bits to accomodate:
1) kind is one of: named, request, reply - request and reply is used for
   inline op records,
2) index for named records (pre defined)
3) L1-L4 for inline records

rfc2 will show it in more details
>
>-- 
>Jason
